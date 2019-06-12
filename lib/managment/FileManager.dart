import 'dart:io';
import 'package:flutter_app/entity/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:serializer/serializer.dart';

class FileManager {

  static final  String stateUserFile = "UserState.txt";
  static final String fileMessageId = "FileMessageId.txt";
  static final String MESSAGE = "IdMessage";

  static const String USER_NAME = 'name';
  static const String TOKEN = 'token';
  static const String USER_ID = 'userId';

  Map<String, String> map = new Map();
  Function _callback;
  Serializer _serializer = new Serializer.json();

  Future<File> _localFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File(directory.path + "/" + fileName);
  }

  void writeUserState(User userGoogle, String token ,String fileName, Function callback)
  async {
    this._callback = callback;
    final file = await _localFile(fileName);
    map["userId"] = userGoogle.getUserId();
    map[USER_NAME] = userGoogle.getName();
    map[TOKEN] = token;
    String json  = _serializer.encode(map);
    map.clear();
    file.writeAsString(json).then((r) {
      this._callback();
    });
  }

  void readFile(String fileName, Function callback) async {
    var file = await _localFile(fileName);
    file.exists().then((exist) {
      if (exist) _read(file, callback);
      else callback(null);
    });
  }

  Future<bool> fileExist(fileName) async {
    final file = await _localFile(fileName);
    bool existOrNot =  await file.exists();
    return existOrNot;
  }
  
  void _read(File file, Function callback) {
    file.readAsString().then((json) {
      Map map = _serializer.decode(json, type: Map);
      callback(map);
    }).catchError(() {
      print("File not faund");
    });
  }

  void writeMessageId(String messageId, String fileName, Function callback)
  async {
    this._callback = callback;
    final file = await _localFile(fileName);
    map[MESSAGE] = messageId;
    String json  = _serializer.encode(map);
    map.clear();
    file.writeAsString(json).then((r) {
      this._callback();
    });
  }

  Future<bool> deleteFile(String fileName) async {
    var file = await _localFile(fileName);
    await file.delete();
    return true;
  }

}

