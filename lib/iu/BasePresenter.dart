
import 'package:flutter_app/iu/BaseView.dart';

abstract class BasePresenter<T extends BaseView> {

  void attachView(T view);
  void detachView();
  void viewReady();
}