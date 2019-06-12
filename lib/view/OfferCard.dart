
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatefulWidget {

   final String discount;
   final String descriptions;
   final String title;
   final String storeImage;
   final String totalCount;
   final String imageProduct;

  const OfferCard({
    Key key,
    this.discount,
    this.descriptions,
    this.title,
    this.storeImage,
    this.totalCount,
    this.imageProduct}) : super(key: key);

  @override
  _OfferCard createState() => _OfferCard();
}

class _OfferCard extends State<OfferCard> {

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: MediaQuery.of(context).size.width,
        margin: new EdgeInsets.symmetric(horizontal: 5.0),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
        ),
        child: Row(

          children: <Widget>[
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                //color: Colors.white,
                child: Container(
                  child: Image.network(widget.imageProduct),
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(5),
                ),
              ),
              flex: 35,
            ),

            Flexible(
              flex: 65,
              child: Container(
                  //color: Colors.grey,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    color: Color.fromARGB(100, 212, 227, 229),
                  ),
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Flexible(
                      flex: 20,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              child: _checkOnNullImage(widget.storeImage),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Container(
                            child: Text(_checkPropsOnNull(widget.title)),
                            padding: EdgeInsets.only(top: 10, left: 6),)
                        ],
                      ),
                    ),

                    Flexible(
                      child: Text(_checkPropsOnNull(widget.descriptions) ,
                        style: TextStyle(fontSize: 15),
                      ),
                      flex: 35,
                    ),

                    Flexible(
                      flex: 20,
                      child: Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Colors.redAccent
                            ),
                            width: _checkLength(),
                            height: 20,
                            child: Container(
                              child: Text(
                                "-" + _checkPropsOnNull(widget.discount),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 2),
                            child: Image(
                                image: AssetImage("lib/res/drawable/coin_min3x.png"),
                                width: 20,
                                height: 20),
                          )
                        ],
                      ),
                    ),

                    Flexible(
                      child: Container(
                        child: Text(_checkPropsOnNull(widget.totalCount), style: TextStyle(fontSize: 24,),),
                        alignment: Alignment.centerLeft,
                      ), flex: 25,
                    )

                  ],
                ),

              ),
            )

          ],
        ),
    );
  }

  Widget _checkOnNullImage(props) {
    if(props == null) {
      return Container();
    } else {
      return Image.network(widget.storeImage);
    }
  }

  _checkPropsOnNull(props) {
    if(props == null) return "";
    else return props;
  }

  double _checkLength() {
    if(widget.discount == null) return 10;
    else return ((widget.discount.length) * 10 + 5).toDouble();
  }
}