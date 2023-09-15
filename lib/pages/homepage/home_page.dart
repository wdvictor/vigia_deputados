import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DeputadoNotifier>(
      builder: (context, deputados, _) {
        return Container();
      },
    ));
  }
}
