import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/entity/Product.dart';
import 'package:flutter_app/entity/UserBody.dart';
import 'package:flutter_app/iu/profile/IProfileViewModel.dart';
import 'package:flutter_app/managment/FileManager.dart';
import 'package:flutter_app/network/NetworkHelper.dart';
import 'package:flutter_app/network/request/RequestDataUser.dart';
import 'package:flutter_app/network/request/RequestOffer.dart';
import 'package:flutter_app/network/request/RequestUserOperations.dart';
import 'package:http/http.dart';

class ProfileViewModel implements IProfileViewModel {

  StreamController<UserResponse> _controllerUser = StreamController<UserResponse>();
  StreamController<List<Operations>> _controllerUserOperations = StreamController<List<Operations>>();
  StreamController<List<Product>> _controllerOffer = StreamController<List<Product>>();
  String urlDataUser = "http://b2p-client.qr4.ru/v1/user/get-data";
  String urlOperations = "http://b2p-client.qr4.ru/v1/user/get-data";
  FileManager       _fileManager;
  NetworkHelper     _networkHelper;
  int               _NO_MESSAGE = 0;
  int               page = 0;

  ProfileViewModel() {
    this._fileManager = new FileManager();
    this._networkHelper = new NetworkHelper();
  }

  @override
  StreamController subscribeDataUser() => _controllerUser;

  @override
  void loadDataUser() => _loadDataUser();

  @override
  void closeStreamUser() => _controllerUser.close();

  @override
  StreamController subscribeUserOperations() => _controllerUserOperations;

  @override
  void nextPageOfOperations() => _pageOfOperations();

  @override
  void reloadPageOfOperations() {
    page = 0;
    _pageOfOperations();
  }

  @override
  void closeStreamUserOperations() => _controllerUserOperations.close();

  @override
  StreamController subscribeOnOffer() => _controllerOffer;

  @override
  void loadOffer() => _loadOffer();

  @override
  void closeStreamOffer() => _controllerOffer.close();


  _loadOffer() {
    _loadUserState((Map stateUser, bool fileExist) {
      _networkHelper
          .requestObservable(new RequestOffer(stateUser[FileManager.TOKEN]))
          .listen((result) {
            Response response = result;
            if(response.body != null) {
              Map map = jsonDecode(response.body);
              List products = map["response"]["products"];
              List<Product> listProducts = new List();
              for(int i = 0; i < products.length; i++) {
                listProducts.add(Product.fromJson(products[i]));
              }

              print(listProducts[1].product_name);
              _controllerOffer.add(listProducts);
            }

          });
    });
  }

  _loadDataUser() {
    _loadUserState((Map stateUser, bool fileExist) {
      if(fileExist) {
        _fileManager.readFile(FileManager.fileMessageId, (Map message) {

          int id = int.parse(message[FileManager.MESSAGE]);
          _loadUser(id, stateUser);

        });
      } else {
        _loadUser(_NO_MESSAGE, stateUser);
      }
    });

  }

  void _loadUser(int id, Map stateUser) {
    String messageId = id.toString();
    _networkHelper
        .requestObservable(new RequestDataUser(
                            stateUser[FileManager.TOKEN],
                            messageId,
                            stateUser[FileManager.USER_ID]

        )).listen((result) {
        Response response = result;
        if(response.body != null) _parsUser(jsonDecode(response.body));
        else print("ERROR");

        });
  }

  void _loadUserState(Function callback) {
    _fileManager.readFile(FileManager.stateUserFile, (Map stateUser) =>
      _fileManager.fileExist(FileManager.fileMessageId).then((bool fileExist) =>
        callback(stateUser, fileExist)
      )
    );
  }

  void _parsUser(Map user) {
    String j = json.encode(user["response"]["user"]);
    final parsed = json.decode(j);
    UserResponse userResponse = UserResponse.fromJson(parsed);
    _controllerUser.add(userResponse);
    _saveLastMessageId(userResponse.messages.last_message_id);
  }

  void _saveLastMessageId(String messageId) {
    _fileManager.writeMessageId(messageId, FileManager.fileMessageId, (){});
  }

  void _pageOfOperations() {

    _loadUserState((Map stateUser, bool fileExist) {
      _networkHelper
          .requestObservable(new RequestUserOperations(stateUser[FileManager.TOKEN], page))
          .listen((result) {
            Response response = result;

            if(response.body != null) {
            Map map = jsonDecode(response.body);
            List operations = map["response"]["operations"];
            List<Operations> listOperations = new List();
            for(int i = 0; i < operations.length; i++) {
              listOperations.add(Operations.fromJson(operations[i]));
            }
            page++;
            _controllerUserOperations.add(listOperations);
          }
        });
    });
  }
}
