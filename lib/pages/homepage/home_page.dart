import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/widgets/animated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final double _initialPosition =
      -500.0; // Posição inicial do menu (fora da tela)
  final double _targetPosition =
      200.0; // Posição final do menu (centro da tela)

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final position = _animationController.value *
                      (_targetPosition - _initialPosition) +
                  _initialPosition;

              return Positioned(
                left: 0,
                right: 0,
                bottom: position,
                child: child!,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedButton(
                  animationMilliseconds: 500,
                  child: MenuOptionButton(
                    title: 'Partidos',
                    callback: () {},
                  ),
                ),
                AnimatedButton(
                  animationMilliseconds: 750,
                  child: MenuOptionButton(
                    title: 'Partidos',
                    callback: () {},
                  ),
                ),
                AnimatedButton(
                  animationMilliseconds: 1000,
                  child: MenuOptionButton(
                    title: 'Partidos',
                    callback: () {},
                  ),
                ),
                AnimatedButton(
                  animationMilliseconds: 1250,
                  child: MenuOptionButton(
                    title: 'Partidos',
                    callback: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuOptionButton extends StatelessWidget {
  const MenuOptionButton({
    Key? key,
    required this.title,
    required this.callback,
  }) : super(key: key);

  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 70,
      decoration: BoxDecoration(
        color: ColorLib.darkBlue.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const Spacer(
            flex: 10,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
