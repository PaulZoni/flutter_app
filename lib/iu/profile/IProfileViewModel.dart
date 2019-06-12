
import 'dart:async';

abstract class IProfileViewModel {

  StreamController subscribeDataUser();
  void closeStreamUser();
  void loadDataUser();
  StreamController subscribeUserOperations();
  void nextPageOfOperations();
  void closeStreamUserOperations();
  void reloadPageOfOperations();
  StreamController subscribeOnOffer();
  void closeStreamOffer();
  void loadOffer();
}