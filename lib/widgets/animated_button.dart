import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton(
      {Key? key, this.animationMilliseconds = 250, required this.child})
      : super(key: key);
  final int animationMilliseconds;
  final Widget child;
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _controllerAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();

    _controllerAnimation = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationMilliseconds));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controllerAnimation, curve: Curves.easeIn));
    _scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controllerAnimation, curve: Curves.easeInOut));

    _controllerAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controllerAnimation,
      builder: (context, child) => Opacity(
        opacity: _opacityAnimation.value,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: widget.child,
        ),
      ),
    );
  }
}
