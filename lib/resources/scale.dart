import 'dart:ui';
import 'package:flutter/material.dart';


FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
Size size = view.physicalSize;

class SizeScale {
  static final screenWidth = size.width;
  static final screenHeight = size.height;
}
