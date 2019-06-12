import 'package:flutter/material.dart';
import 'package:flutter_app/iu/authorization/AuthorizationView.dart';
import 'package:flutter_app/iu/game/GameView.dart';
import 'package:flutter_app/iu/store/StoreView.dart';
import 'package:flutter_app/iu/profile/ProfileView.dart';
import 'package:flutter_app/managment/FileManager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  FileManager fileManager = new FileManager();
  fileManager.fileExist(FileManager.stateUserFile).then((fileExist) {
    if (fileExist) {
      runApp(MyApp());
    } else {
      runApp(MyAppSingle());
    }
  });
}


class MyAppSingle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthorizationView(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // app-specific localization delegate here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ru', 'RU'),
        // ... other locales the app supports
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<Home> {

  TextStyle _textStyleNotActive = new TextStyle(color: Color.fromRGBO(157, 209, 251, 1));
  var _activeIconProfile = AssetImage("lib/res/drawable/icon_profile_blue.png");
  var _iconProfile = AssetImage("lib/res/drawable/icon_profile_blue@3x.png");
  var _iconGame = AssetImage("lib/res/drawable/icon_game_transparent.png");
  var _iconGameNotActive = AssetImage("lib/res/drawable/icon_game_transparent_not_active3.png");
  int _currentIndex = 0;

  final List<Widget> _children = [
    Stack(
      children: <Widget>[

        Navigator(
          onGenerateRoute: (RouteSettings settings) {
            return new MaterialPageRoute(
              builder: (_) => ProfileView(),
            );
          },
        )

      ],
    ),

    GameView(),
    StoreView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(data: Theme.of(context).copyWith(
          canvasColor: Colors.blue,
          splashColor: Colors.white,
          unselectedWidgetColor: Colors.blue,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(caption: _textStyleNotActive),
      ), child: BottomNavigationBar(
        onTap: _onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image(image: _activeIconProfile, width: 24, height: 24,),
            icon: Image(image: _iconProfile, width: 24, height: 24),
            title: new Text('Профиль'),
          ),
          BottomNavigationBarItem(
            activeIcon: Image(image: _iconGame, width: 24, height: 24),
            icon: Image(image: _iconGameNotActive, width: 24, height: 24),
            title: new Text('Игры'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
      )),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


