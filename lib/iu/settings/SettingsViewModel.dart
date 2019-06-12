import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/iu/settings/ISettingsViewModel.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/managment/FileManager.dart';
import 'package:flutter_app/network/socialnetwork/GoogleLogIn.dart';


class SettingsViewModel implements ISettingsViewModel {

  GoogleLogIn _googleLogIn;
  FileManager _fileManager;
  StreamController<String> _controllerName = StreamController<String>();

  SettingsViewModel() {
    _googleLogIn = new GoogleLogIn();
    _fileManager = new FileManager();
  }

  @override
  void singOut() {
    _googleLogIn.handleSignOut().then((notValue) {
      _fileManager.deleteFile(FileManager.fileMessageId);
      _fileManager.deleteFile(FileManager.stateUserFile);
      runApp(MyAppSingle());
    });
  }

  @override
  void closeStreamName() {
    _controllerName.close();
  }

  @override
  void loadName() => _loadName();

  @override
  StreamController<String> subscribeForName() => _controllerName;

  _loadName() {
    _fileManager.readFile(FileManager.stateUserFile, (Map stateUser) {
      _controllerName.add(stateUser[FileManager.USER_NAME]);
    });
  }

}