import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/iu/authorization/IViewModelAuthorization.dart';
import 'package:flutter_app/iu/authorization/ViewModelAuthorization.dart';
import 'package:flutter_app/main.dart';

class AuthorizationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthorizationView();
}


class _AuthorizationView extends State<AuthorizationView> {

  var _logo = AssetImage("lib/res/drawable/Scrin@3x.png");
  IViewModelAuthorization _presenterAuthorization;

  @override
  void initState() {
    super.initState();
    _presenterAuthorization = new ViewModelAuthorization();

  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double heightOne = width / 3;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[

            Flexible(
              flex: 1,
                child: Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image(image: _logo, width: 159, height: 184),
                    ),
                  ),
            )),

            Flexible(
              flex: 1,
                child: Container(
                  child: Stack(
                    children: <Widget>[

                      Align(
                        alignment: FractionalOffset.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: Text(
                            "Зарегистрируйтесь\n через социальные сети",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),

                      Center(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                flex: 1,
                                child: _Button(
                                    heightOne, Colors.blue, () {})
                            ),
                            Container(
                              color: Colors.white,
                              width: 1,
                              height: heightOne,
                            ),
                            Flexible(
                                flex: 1,
                                child: _Button(
                                    heightOne,
                                    Color.fromRGBO(59, 89, 165, 1),
                                        () {}),
                            ),
                            Container(
                              color: Colors.white,
                              width: 1,
                              height: heightOne,
                            ),
                            Flexible(
                                flex: 1,
                                child: _Button(
                                    heightOne,
                                    Color.fromRGBO(223, 80, 68, 1),
                                    _loginGoogle),
                            )
                          ],
                        ),
                      ),

                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Text(
                            "Нажимая на кнопку, соглашаюсь\nс политикой конфиденциальности",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  void _loginGoogle() {
    StreamController streamController = _presenterAuthorization.loginGoogle();
    streamController.stream.listen((answer) {
      if(answer) {
        startApp();
        streamController.close();
      }
    });
  }

  Widget _Button(double heightOne, Color c, Function callback ) {
    return Container(
      child: new Material(
        child: new InkWell(
          onTap: () {
            callback();
          },
          child: new Container(
            height: heightOne,
          ),
        ),
        color: Colors.transparent,
      ),
      color: c,
    ) ;
  }

  void startApp() {
    runApp(MyApp());
  }
}