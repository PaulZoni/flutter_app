
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;
import 'package:flutter_app/view/pulltorefresh/Config.dart';
import 'package:flutter_app/view/pulltorefresh/SmartRefresher.dart';


abstract class Wrapper extends StatefulWidget {
  final ValueNotifier<int> modeListener;

  final IndicatorBuilder builder;

  final bool up;

  final double triggerDistance;

  bool get _isRefreshing => this.mode == RefreshStatus.refreshing;

  bool get _isComplete =>
      this.mode != RefreshStatus.idle &&
          this.mode != RefreshStatus.refreshing &&
          this.mode != RefreshStatus.canRefresh;

  int get mode => this.modeListener.value;

  set mode(int mode) => this.modeListener.value = mode;

  Wrapper(
      {Key key,
        @required this.up,
        @required this.modeListener,
        this.builder,
        this.triggerDistance})
      : assert(up != null, modeListener != null),
  super(key: key);

  bool _isScrollToOutSide(ScrollNotification notification) {
    if (up) {
      if (notification.metrics.minScrollExtent - notification.metrics.pixels >
          0) {
        return true;
      }
    } else {
      if (notification.metrics.pixels - notification.metrics.maxScrollExtent >
          0) {
        return true;
      }
    }
    return false;
  }
}
