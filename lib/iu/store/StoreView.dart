
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoreView extends StatefulWidget {

  const StoreView({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}


class _MyTabbedPageState extends State<StoreView> with SingleTickerProviderStateMixin {

  TabController _tabController;
  Text textTitle = new Text("Магазины", style: TextStyle(fontSize: 22, color: Colors.white));

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Все'),
    Tab(text: 'Электроника'),
    Tab(text: 'Для дома'),
    Tab(text: 'Косметика'),
    Tab(text: 'Украшения'),
    Tab(text: 'Одежда'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
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