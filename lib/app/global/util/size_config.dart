import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  void initialize(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
  }

  static double unitHeight = mediaQueryData.size.height / 100;
  static double unitWidth = mediaQueryData.size.width / 100;

  static double height = mediaQueryData.size.height;
  static double width = mediaQueryData.size.width;
}
