import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/iu/settings/ISettingsViewModel.dart';
import 'package:flutter_app/iu/settings/SettingsViewModel.dart';
import 'package:flutter_app/utils/strings/StringsLocalizations.dart';

class SettingsView extends StatefulWidget {

  final int isOffer;

  const SettingsView({Key key, this.isOffer}) : super(key: key);

  @override
  _SettingsView createState() => _SettingsView();
}

class _SettingsView extends State<SettingsView> {

  ISettingsViewModel _viewModel;
  String _userName = 'name';
  bool _enabled = false;

  _SettingsView() {
    _viewModel = new SettingsViewModel();
  }

  @override
  void initState() {
    super.initState();
    _subscribeForName();
    _viewModel.loadName();
    _checkShowOffer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          StringsLocalizations.getString(context, "settings"),
          style: TextStyle(color: Colors.blue,),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),

      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: <Widget>[

                _containerSingOut(context),

                _separateLine(),

                _containerChangeName(context),

                _separateLine(),

                Flexible(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Row(
                      children: <Widget>[

                        Flexible(
                          flex: 70,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Align(
                              child: Text(
                                'Получать уведомления о товарах',
                                style: TextStyle(),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ),

                        Flexible(
                          flex: 30,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Align(
                              child: Switch(value: _enabled, onChanged: (bool value) {
                                setState(() {
                                  _enabled = value;
                                });
                              }),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                  flex: 25,
                )


              ],
            ),
          ),
          flex: 40,
        ),

        Flexible(child: Container(), flex: 60,)
      ],
    );
  }

  _alertSingOut() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: SizedBox(

          height: 100,
          child: Column(
            children: <Widget>[
              Text(
                StringsLocalizations.getString(context, "Sign_out?"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                          onPressed: _viewModel.singOut,
                          child: Text(
                            StringsLocalizations.getString(context, "Yes"),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black
                            ),
                          )
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 15),
                      width: 1,
                      height: 20,
                      color: Colors.grey,
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(left: 25),
                        child: FlatButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(
                              StringsLocalizations.getString(context, "No"),
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),

        contentPadding: EdgeInsets.all(30),
      );
    });
  }

  Widget _containerChangeName(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: <Widget>[

            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  child: Text(
                    'Сменить имя',
                    style: TextStyle(),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),

            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  child: FlatButton(
                    onPressed: () {

                    },
                    child: Image(
                      image: AssetImage(
                          "lib/res/drawable/name_change@3x.png"
                      ),
                      width: 22,
                      height: 24,
                    ),
                    padding: EdgeInsets.only(left: 25),
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            )

          ],
        ),
      ),
      flex: 25,
    );
  }

  Widget _containerSingOut(BuildContext context) {
    return Flexible(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: <Widget>[

            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  child: Text(
                    _userName,
                    style: TextStyle(),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ),

            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      onTap: _alertSingOut,
                      child: Container(
                        padding: EdgeInsets.only(top: 6),
                        width: 87,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(20, 0, 0, 0),
                            borderRadius: BorderRadius.circular(15)
                        ),

                        child: Text(
                          StringsLocalizations.getString(context, "GO_OUT"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                  alignment: Alignment.centerRight,
                ),
              ),
            )

          ],
        ),
      ),
      flex: 48,
    );
  }

  Widget _separateLine() {
    return Flexible(
      flex: 1,
      child: Container(color: Colors.grey, width: double.infinity, height: 1,),
    );
  }

  _subscribeForName() {
    _viewModel.subscribeForName().stream.listen((name) {
      setState(() {
        _userName = name;
      });
    });
  }

  _checkShowOffer() {
    if(widget.isOffer == 1) {
      setState(() {
        _enabled = true;
      });
    } else {
      setState(() {
        _enabled = false;
      });
    }
  }

}
