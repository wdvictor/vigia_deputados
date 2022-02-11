//cSpell:ignore cupertino RGBO
import 'package:flutter/cupertino.dart';

enum ColorLib {
  blue,
  green,
  opaqueWhite,
}

extension ColorLibExtension on ColorLib {
  static const Map<ColorLib, Color> names = {
    ColorLib.blue: Color.fromRGBO(16, 140, 204, 1),
    ColorLib.green: Color.fromRGBO(82, 184, 74, 1),
    ColorLib.opaqueWhite: Color.fromRGBO(209, 230, 244, 1)
  };

  Color get color => names[this]!;
}
