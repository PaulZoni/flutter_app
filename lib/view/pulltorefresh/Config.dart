

import 'package:flutter/cupertino.dart';

abstract class Config {
  // How many distances should be dragged to trigger refresh
  final double triggerDistance;

  const Config({this.triggerDistance});
}

class RefreshConfig extends Config {
  // display time of success or failed
  final int completeDuration;
  // emptySpace height
  final double visibleRange;
  const RefreshConfig(
      {this.visibleRange: default_VisibleRange,
        double triggerDistance: default_refresh_triggerDistance,
        this.completeDuration: default_completeDuration})
      : super(triggerDistance: triggerDistance);
}

class LoadConfig extends Config {
  // if autoLoad when touch outside
  final bool autoLoad;
  // Whether the interface is at the bottom when the interface is loaded
  final bool bottomWhenBuild;

  final bool enableOverScroll;
  const LoadConfig({
    this.autoLoad: default_AutoLoad,
    this.bottomWhenBuild:default_BottomWhenBuild,
    this.enableOverScroll :default_enableOverScroll,
    double triggerDistance: default_load_triggerDistance,
  }) : super(triggerDistance: triggerDistance);
}




typedef void OnRefresh(bool up);
typedef void OnOffsetChange(bool up, double offset);
typedef Widget IndicatorBuilder(BuildContext context, int mode);

const int default_completeDuration = 800;

const double default_refresh_triggerDistance = 100.0;

const double default_load_triggerDistance = 5.0;

const double default_VisibleRange = 50.0;

const bool default_AutoLoad = true;

const bool default_enablePullDown = true;

const bool default_enablePullUp = false;

const bool default_BottomWhenBuild = true;

const bool default_enableOverScroll = true;

const int spaceAnimateMill=300;

const double minSpace = 0.000001;