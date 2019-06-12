

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {

  final String name;
  final String hours;
  final String countGame;
  final Function clickListener;

  Header({ Key key, this.name, this.hours, this.countGame, this.clickListener}): super(key: key);

  @override
  _HeaderState createState() => new _HeaderState();

}


class _HeaderState extends State<Header> {

  var _imageSettings = AssetImage("lib/res/drawable/icon_settings_blue@3x.png");
  var _indicator = SizedBox(
    width: 18,
    height: 18,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Container(
        color: Colors.blue,
        child: Column(

          children: <Widget>[
            Flexible(
                flex: 40,
                child: Container(
                  child: Row(

                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Align(
                              alignment: FractionalOffset.centerLeft,
                              child: _userName(),
                            ),
                          )
                      ),

                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: FractionalOffset.centerRight,
                              child: _buttonSettings(),
                            ),
                          )
                      )
                    ],

                  ),
                )
            ),

            Flexible(
                flex: 44,
                child: Container(
                  padding: EdgeInsets.only(top: 6, bottom: 3),
                  child: Row(

                    children: <Widget>[
                      Flexible(
                          flex: 40,
                          child: Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              children: <Widget>[

                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _countGame(),
                                        Text(
                                            "установлено",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                      ),

                      Flexible(
                          flex: 60,
                          child: Container(
                            child: Row(
                              children: <Widget>[

                                Container(color: Color.fromARGB(100, 255, 255, 255), width: 1,),

                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _hoursInGame(),
                                        Text("в игре",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                )

                              ],
                            ),
                          )
                      ),
                    ],

                  ),
                )
            ),

            Flexible(
                flex: 16,
                child: Container(color: Colors.blue,)
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _userName() {
    if(widget.name == null) return _indicator;
    else return Text(widget.name, style: TextStyle(color: Colors.white));
  }

  Widget _countGame() {
    if(widget.countGame == null) return _indicator;
    else return Text(
        widget.countGame + " игр",
        style: TextStyle(fontSize: 19, color: Colors.white)
    );
  }

  Widget _hoursInGame() {
    if (widget.hours == null) return _indicator;
    else return Text(
        widget.hours + " часов",
        style: TextStyle(fontSize: 19, color: Colors.white)
    );
  }

  Widget _buttonSettings() {
    return GestureDetector(
      onTap: widget.clickListener,
      child: Image(image: _imageSettings, width: 24, height: 24),
    );
  }

}