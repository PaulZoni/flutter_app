import 'dart:async';

abstract class ISettingsViewModel {

  void singOut();
  void closeStreamName();
  void loadName();
  StreamController<String> subscribeForName();
}