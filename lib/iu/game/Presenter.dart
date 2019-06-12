import 'package:flutter/material.dart';
import 'package:flutter_app/iu/game/IPresenter.dart';

class PresenterGame implements IPresenterGame {

  var _view;

  @override
  void click(BuildContext c) {
    Navigator.pop(c);
  }

  @override
  void attachView(IViewGame view) {
    this._view = view;
  }

  @override
  void detachView() {
    this._view = null;
  }

  @override
  void viewReady() {
    // TODO: implement viewReady
  }

}