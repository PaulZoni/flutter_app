
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardOperations extends StatefulWidget {

  final String time;
  final String name;
  final String count;

  const CardOperations({Key key, this.time, this.name, this.count}) : super(key: key);

  @override
  _CardOperations createState() => _CardOperations();

}

class _CardOperations extends State<CardOperations> {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 62,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Container(
            height: 61,
            width: double.infinity,
            child: Row(
              children: <Widget>[

                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Column(
                      children: <Widget>[
                        Align(child: Text(_check(widget.name), style: TextStyle(color: Colors.black54, fontSize: 15)),alignment: FractionalOffset.centerLeft),
                        Align(child: Text(_check(widget.time), style: TextStyle(color: Colors.black45, fontSize: 13)), alignment: FractionalOffset.centerLeft,)
                      ],
                    ),
                    width: double.infinity, height: double.infinity,
                  ),
                  flex: 1,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 22),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Text(_check(widget.count)), alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 6),
                            ),
                            Container(
                              child: Image(
                                image: AssetImage("lib/res/drawable/coin_min3x.png"),
                                width: 20,
                                 height: 20,
                              ),
                              alignment: Alignment.centerRight,
                            )
                          ],
                        )
                      ],
                    ),
                    width: double.infinity, height: double.infinity,
                  ),
                  flex: 1,
                )

              ],
            ),
          ),
          Container(
            color: Colors.black12,
            height: 1,
            width: double.infinity,

          )
        ],
      ),

    );
  }


  _check(props) {
    if(props == null) return "";
    else return props;
  }

}