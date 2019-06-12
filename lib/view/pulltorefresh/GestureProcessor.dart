import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' hide RefreshIndicator;

abstract class GestureProcessor {
  void onDragStart(ScrollStartNotification notification);

  void onDragMove(ScrollUpdateNotification notification);

  void onDragEnd(ScrollNotification notification);
}



