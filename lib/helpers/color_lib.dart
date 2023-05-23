import 'package:flutter/material.dart';

enum ColorLib {
  lightBlue,
  darkBlue,
  darkGreen,
  lightGreen,
  almostWhite,
  mediumBlue,
  mediumGreen
}

enum DarkThemeLib { primaryBackgroundColor, primaryColor, secondaryColor }

extension DarkTheme on DarkThemeLib {
  static const Map<DarkThemeLib, int> names = {
    DarkThemeLib.primaryBackgroundColor: 0xFF171717,
    DarkThemeLib.primaryColor: 0xFFC3C3C3,
    DarkThemeLib.secondaryColor: 0xFF36373B
  };

  Color get color => Color(names[this]!);
}

extension ColorLibExtension on ColorLib {
  static const Map<ColorLib, int> names = {
    ColorLib.lightBlue: 0xFF79B4D9,
    ColorLib.darkBlue: 0xFF0339A6,
    ColorLib.mediumBlue: 0xFF118EBF,
    ColorLib.darkGreen: 0xFF03A61C,
    ColorLib.mediumGreen: 0xFF5DBF4E,
    ColorLib.lightGreen: 0xFF5DBF4E,
    ColorLib.almostWhite: 0xFFF2F2F2,
  };

  Color get color => Color(names[this]!);
}
