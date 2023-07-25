//cSpell:ignore cupertino RGBO
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/models/all_deputados_notifier.dart';
import 'package:vigia_deputados/pages/homepage/home_page.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllDeputadosNotifier(currentPage: 1)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


///Attributions required:
///Image by storyset on Freepik
