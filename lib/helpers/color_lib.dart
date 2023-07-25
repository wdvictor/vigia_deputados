import 'package:flutter/material.dart';

enum ColorLib { primaryColor, whiteLilac, lightBrown, toastedYellow, brown }

extension ColorLibExtension on ColorLib {
  static const Map<ColorLib, int> names = {
    ColorLib.primaryColor: 0xFF283926,
    ColorLib.whiteLilac: 0xFFEEEEFA,
    ColorLib.lightBrown: 0xFFD9D2B0,
    ColorLib.toastedYellow: 0xFFF2B33D,
    ColorLib.brown: 0xFFA65D03,
  };

  Color get color => Color(names[this]!);
}
