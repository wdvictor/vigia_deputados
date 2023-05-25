import 'package:flutter/material.dart';

enum ColorLib { pinkBrown, darkPink, lightPink, violet, greyPink }

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
    ColorLib.pinkBrown: 0xFF400D1F,
    ColorLib.darkPink: 0xFFBD1FBF,
    ColorLib.lightPink: 0xFFEF4BF2,
    ColorLib.violet: 0xFF471C59,
    ColorLib.greyPink: 0xFFDBC4F2,
  };

  Color get color => Color(names[this]!);
}
