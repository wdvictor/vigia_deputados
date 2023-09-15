import 'package:flutter/material.dart';

class BottomToCenterAnimation extends StatefulWidget {
  const BottomToCenterAnimation({Key? key}) : super(key: key);

  @override
  State<BottomToCenterAnimation> createState() =>
      _BottomToCenterAnimationState();
}

class _BottomToCenterAnimationState extends State<BottomToCenterAnimation>
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
      duration: const Duration(seconds: 1),
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
            child: const Text('Your widget here'),
          ),
        ],
      ),
    );
  }
}
