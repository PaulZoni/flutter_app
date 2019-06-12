
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountCard extends StatefulWidget {

  final String count;
  final bool disable;
  final Function onClick;

  const CountCard({Key key, this.count, this.disable, this.onClick}) : super(key: key);

  @override
  _CountCard createState() => _CountCard();

}

class _CountCard extends State<CountCard> {

  var _countCard = AssetImage("lib/res/drawable/count_card@3x.png");
  var _countCardDisable = AssetImage("lib/res/drawable/ic_card_disable@3x.png");
  var _indicator = SizedBox(
    width: 28,
    height: 28,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor:  AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: _selectImage(),
          fit: BoxFit.fill,
        ),
      ),

      child: Container(
        width: 300,
        height: 170,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 20,
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("всего на счету", style: TextStyle(fontSize: 14, color: Color.fromARGB(50, 0, 0, 0)))
              ),
            ),
            Flexible(
              flex: 40,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _count(),
                      Container(
                        padding: EdgeInsets.only(top: 7, left: 4),
                        child: Image(image: AssetImage("lib/res/drawable/g_dollar_28px@3x.png"), width: 28, height: 28),
                      )
                    ],
                  ),
                ),
            ),
            Flexible(
                flex: 40,
                child: Container(
                    child: Align(
                      widthFactor: double.infinity,
                      heightFactor: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            flex: 60,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: GestureDetector(
                                  onTap: _buttonClick,
                                  child: Center(
                                      child: Text("использовать", style: TextStyle(fontSize: 15, color: Colors.white),),
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                            flex: 40,
                              child: Container()
                          )
                        ],
                      ),
                    ),
                )
            ),

          ],
        ),
      ),
    );
  }

  Widget _count() {
    if(widget.count == null) return Container(child: _indicator, padding: EdgeInsets.only(top: 4));
    else return Text(
        widget.count,
        style: TextStyle(
            fontSize: 36, color: Color.fromARGB(90, 0, 0, 0)
        )
    );
  }

  AssetImage _selectImage() {
    if(widget.count != null && double.parse(widget.count) > 0) return _countCard;
    else return _countCardDisable;
  }

  _buttonClick() {
    if(widget.count != null && double.parse(widget.count) > 0) {
      widget.onClick();
    }
  }
}
