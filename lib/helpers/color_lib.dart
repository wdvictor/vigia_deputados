import 'package:flutter/material.dart';

enum ColorLib { darkBlue, green, lightBrown, toastedYellow, brown }

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
    ColorLib.darkBlue: 0xFF060826,
    ColorLib.green: 0xFF038C4C,
    ColorLib.lightBrown: 0xFFD9D2B0,
    ColorLib.toastedYellow: 0xFFF2B33D,
    ColorLib.brown: 0xFFA65D03,
  };

  Color get color => Color(names[this]!);
}
