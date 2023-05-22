//cSpell:ignore cupertino RGBO
import 'package:flutter/cupertino.dart';

import 'package:vigia_deputados/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      // theme: CupertinoThemeData(
      //     // TODO: Dark theme
      //     //brightness: Brightness.dark
      //     //scaffoldBackgroundColor: ColorLib.opaqueWhite.color,
      //     ),
      home: HomePage(),
    );
  }
}
