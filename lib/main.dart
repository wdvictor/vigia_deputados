//cSpell:ignore cupertino RGBO
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';
import 'package:vigia_deputados/pages/homepage/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeputadoNotifier()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

//TODO implementar shimmer no loading da homepage