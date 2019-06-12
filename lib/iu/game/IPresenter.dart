
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/iu/BasePresenter.dart';
import 'package:flutter_app/iu/BaseView.dart';


abstract class IPresenterGame extends BasePresenter<IViewGame> {
  void click(BuildContext c);
}


abstract class IViewGame extends BaseView<IPresenterGame> {}
