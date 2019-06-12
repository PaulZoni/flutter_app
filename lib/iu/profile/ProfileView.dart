import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_app/entity/Product.dart';
import 'package:flutter_app/entity/UserBody.dart';
import 'package:flutter_app/iu/settings/SettingsView.dart';
import 'package:flutter_app/iu/profile/IProfileViewModel.dart';
import 'package:flutter_app/iu/profile/ProfileViewModel.dart';
import 'package:flutter_app/view/CardOperations.dart';
import 'package:flutter_app/view/CountCard.dart';
import 'package:flutter_app/view/Header.dart';
import 'package:flutter_app/view/OfferCard.dart';
import 'package:flutter_app/view/pulltorefresh/ClassicIndicator.dart';
import 'package:flutter_app/view/pulltorefresh/SmartRefresher.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProfileView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileView();
}


class _ProfileView extends State<ProfileView> {

  IProfileViewModel _viewModel;
  UserResponse _userResponse;
  int _listOperationsSize = 0;
  var _refreshController = new RefreshController();
  List<Operations> _listOperations;
  List<Product> _listProduct;
  ListView listView;
  int _notifications = 0;

  _ProfileView() {
    this._viewModel = new ProfileViewModel();
  }

  @override
  void initState() {
    super.initState();
    _subscribe();
    _viewModel.nextPageOfOperations();
    _viewModel.loadDataUser();
    _viewModel.loadOffer();
  }

  _subscribe() {
    _viewModel.subscribeDataUser().stream.listen((user) {
      setState(() {
        _userResponse = user;
        _notifications = _userResponse.receive_notifications;
      });
    });

    _viewModel.subscribeUserOperations().stream.listen((operations) {
      setState(() {

        if(_listOperations != null) _listOperations.addAll(operations);
        else _listOperations = operations;
        _listOperationsSize = _listOperations.length;
        print(_listOperationsSize);
      });
    });

    _viewModel.subscribeOnOffer().stream.listen((product) {
      setState(() {
        _listProduct = product;
      });
    });
  } 

  Widget _list(context) {

    listView = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal:0, vertical: 0 ),
      itemCount: _listOperationsSize == 0? 2: _listOperationsSize + 2,
      itemBuilder: (context,  index) {
        if (index == 0) {
          return _countCard();
        } else if(index == 1) {
          return _carousel();
        } else {
          index -= 2;
          return _cardView(context, index);
        }
      },
    );

    return listView;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        carouselSize: 200,
        countSize: 190,
        containerForHeader: _header(context),
        listenerTheEndList: _listenerEnd,
        controller: _refreshController,
        headerBuilder: _buildHeader,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh,
        child: _list(context),
      ),
    );
  }

  Widget _buildHeader(context, mode) {
    return new ClassicIndicator(mode: mode);
  }

  Widget _cardView(context,  index) {
    return CardOperations(
      count: _listOperations == null? null: _listOperations[index].coin_change,
      name: _listOperations == null? null: _listOperations[index].source_name,
      time: _listOperations == null? null: _listOperations[index].operation_date.toString(),
    );
  }

  Widget _header(BuildContext context) {
    return Header(
      name: _userResponse == null? null: _userResponse.user_name,
      countGame: _userResponse == null? null: _userResponse.installed_apps,
      hours: _userResponse == null? null: _userResponse.time_in_apps,
      clickListener: () {

        Navigator.of(context,)
            .push(MaterialPageRoute(builder: (context) => new SettingsView(isOffer: _notifications,)));


      },
    );
  }

  void _onRefresh(bool up){
    if(up){
      //headerIndicator callback
      setState(() {
        _clearDataUser();
      });
      new Future.delayed(const Duration(milliseconds: 2009))
          .then((val) {
            _refreshController.sendBack(true, RefreshStatus.failed);
            _viewModel.loadDataUser();
            _viewModel.reloadPageOfOperations();
      });
    } else{
      //footerIndicator Callback
    }
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.closeStreamUser();
    _viewModel.closeStreamOffer();
    _viewModel.closeStreamOffer();
  }
  
  Widget _countCard() {
    return SizedBox(
      width: double.infinity,
      height: 190,
      child: Container(
        color: Color.fromARGB(100, 228, 228, 228),
        child: Center(
          child: CountCard(
            onClick: () {
              print("CountCard");
              },
            count: _userResponse == null? null: _userResponse.coin_count.toString(),
          ),
        ),
      ),
    );
  }

  Widget _carousel() {
    return Container(
      width: double.infinity,
      height: (_listProduct == null || _notifications == 0)? 0: 200,
      color: Color.fromARGB(100, 228, 228, 228),
      child: Align(
        alignment: FractionalOffset.topCenter,
        child: _listProduct == null? Container(): _slider(),
      ),
    );
  }

  Widget _slider() {
    return new CarouselSlider(
        items: _listProduct.map((product) {
          return new Builder(
            builder: (BuildContext context) {
              return OfferCard(
                discount: _listProduct == null? null: product.coin_price,
                descriptions: _listProduct == null? null: product.product_name,
                title: _listProduct == null? null: product.store_name,
                totalCount: _listProduct == null? null: product.price,
                storeImage: _listProduct == null? null: product.store_icon,
                imageProduct: _listProduct == null? null: product.image_link,
              );
            },
          );
        }).toList(),
        height: 160.0,
        autoPlay: false,
        distortion: false,
        interval: const Duration(seconds: 8),
        autoPlayDuration: const Duration(milliseconds: 2000),
    );
  }

  _listenerEnd() {
    _viewModel.nextPageOfOperations();
  }

  _clearDataUser() {
    _userResponse = null;
    _listOperations = null;
    _listOperationsSize = 0;
  }
}
