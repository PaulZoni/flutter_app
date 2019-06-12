import 'dart:async';
import 'package:flutter_app/entity/User.dart';
import 'package:flutter_app/iu/authorization/IViewModelAuthorization.dart';
import 'package:flutter_app/managment/FileManager.dart';
import 'package:flutter_app/network/NetworkHelper.dart';
import 'package:flutter_app/network/request/IRequest.dart';
import 'package:flutter_app/network/request/RequestDataUser.dart';
import 'package:flutter_app/network/request/RequestHandleUser.dart';
import 'package:flutter_app/network/socialnetwork/GoogleLogIn.dart';
import 'package:flutter_app/utils/Decoder.dart';

import 'package:http/http.dart';

class ViewModelAuthorization implements IViewModelAuthorization {
  
  GoogleLogIn _googleLogIn;
  NetworkHelper _networkHelper;
  FileManager _manager ;
  StreamController _ctrl = StreamController();

  ViewModelAuthorization() {
    this._googleLogIn = new GoogleLogIn();
    this._networkHelper = new NetworkHelper();

    this._manager = new FileManager();
  }

  @override
  StreamController loginGoogle() {
    _googleLogIn.handleSignIn((User user) {

        if(user != null) _registration(user, new RequestHandleUser(user));
    });

    return this._ctrl;
  }

  void _registration(User user, IRequest request) {
    _networkHelper.requestObservable(request).listen((res) {
      if(res != null) {

        Response response = res;
        String token = parsUrl(response.headers["location"]);
        user.setUserId(Decoder.tokenDecoder(token));
        _manager.writeUserState(user, token, FileManager.stateUserFile, () {
          this._ctrl.sink.add(true);
          _ctrl.close();
        });
      }
    });
  }

  String parsUrl(String url) {
    var a = url.split('=');
    var b = a[1].split('&');
    return b[0];
  }

}