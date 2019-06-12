
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/iu/game/IPresenter.dart';
import 'package:flutter_app/iu/game/Presenter.dart';


class GameView extends StatefulWidget {

  GameView({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _GameView();
}


class _GameView extends State<GameView> with SingleTickerProviderStateMixin
    implements IViewGame {

  IPresenterGame presenter = new PresenterGame();
  Text textTitle = new Text("Игры", style: TextStyle(fontSize: 22, color: Colors.white));
  TabController _tabController;

  List<Tab> myTabs = <Tab>[
    Tab(text: 'Все'),
    Tab(text: 'Боевики'),
    Tab(text: 'Приключения'),
    Tab(text: 'Аркады'),
    Tab(text: 'Настольные'),
    Tab(text: 'Карточные'),
    Tab(text: 'Казино'),
    Tab(text: 'Игры в кости'),
    Tab(text: 'Обучающие'),
    Tab(text: 'Семейные'),
    Tab(text: 'Музыка'),
    Tab(text: 'Головоломки'),
    Tab(text: 'Гонки'),
    Tab(text: 'Ролевые игры'),
    Tab(text: 'Симуляторы'),
    Tab(text: 'Спорт'),
    Tab(text: 'Стратегии'),
    Tab(text: 'Викторины'),
    Tab(text: 'Словесные'),
  ];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    presenter.attachView(this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: textTitle,
        flexibleSpace: Container(
          margin: EdgeInsets.only(left: 16, top: 60),
          child: textTitle,
        ),
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
            child:Stack(
              children: <Widget>[
                _line(),
                _tab(),
              ],
            ),
            preferredSize: Size(1, 70)),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(child: Text(tab.text));
        }).toList(),
      ),
    );
  }

  Widget _line() {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Divider(
        color: Colors.white,
        height: 5,
      ),
    );
  }

  Widget _tab() {
    return TabBar(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Colors.white, width: 4.0),
        insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
      ),
      isScrollable: true,
      controller: _tabController,
      tabs: myTabs,
    );
  }

}
