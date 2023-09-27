import 'package:flutter/material.dart';

class DeviceInfo {
  static bool isTablet(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }
}
