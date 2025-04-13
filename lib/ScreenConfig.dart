import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';

class ScreenConfig {
  static final ScreenConfig _instance = ScreenConfig._internal();
  factory ScreenConfig() => _instance;
  ScreenConfig._internal();

  late double screenWidth;
  late double screenHeight;
  late Orientation orientation;
  late bool isTablet;

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    orientation = mediaQuery.orientation;
    isTablet = screenWidth > 600;
  }

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;
}