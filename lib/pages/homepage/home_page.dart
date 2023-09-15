import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final double _initialPosition = -500.0; // Posição inicial do menu (fora da tela)
  final double _targetPosition = 150.0; // Posição final do menu (centro da tela)

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.darkBlue.color,
        centerTitle: true,
        title: const Text('Vigia Deputados'),
      ),
      body: Consumer<DeputadoNotifier>(
        builder: (context, deputados, _) {
          if (deputados.deputados == null) {
            deputados.fetchDeputados();
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
