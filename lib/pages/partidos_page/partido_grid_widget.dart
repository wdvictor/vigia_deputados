import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material, Colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/partidos_response.dart';

class PartidoWidget extends StatefulWidget {
  const PartidoWidget(
      {Key? key,
      required this.dado,
      required this.animationMillisecondsDuration})
      : super(key: key);
  final Dado dado;
  final int animationMillisecondsDuration;
  @override
  State<PartidoWidget> createState() => _PartidoWidgetState();
}

class _PartidoWidgetState extends State<PartidoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationMillisecondsDuration),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorLib.darkBlue.color,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: Text(
                            widget.dado.sigla,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: CupertinoColors.white),
                          ),
                        ),
                        Text(
                          widget.dado.nome,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
