import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vigia_deputados/helpers/color_lib.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: ColorLib.almostWhite.color,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(
                'images/app_icon.png',
                width: 100,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Vigia Deputados',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    MainMenuOption(
                      optionColor: ColorLib.darkBlue.color,
                      title: 'Partidos',
                      imageAsset: 'lime-flag-1.png',
                      animationMillisecondsDuration: 250,
                    ),
                    MainMenuOption(
                      optionColor: ColorLib.darkBlue.color,
                      title: 'Deputados',
                      imageAsset: 'clip-politician-1.png',
                      animationMillisecondsDuration: 500,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    MainMenuOption(
                      optionColor: ColorLib.darkGreen.color,
                      title: 'Proposições',
                      imageAsset: 'congresswoman.png',
                      animationMillisecondsDuration: 750,
                    ),
                    MainMenuOption(
                      optionColor: ColorLib.darkGreen.color,
                      title: 'Votações',
                      imageAsset: 'urban-online-voting.png',
                      animationMillisecondsDuration: 1000,
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class MainMenuOption extends StatefulWidget {
  const MainMenuOption({
    Key? key,
    required this.optionColor,
    required this.title,
    required this.imageAsset,
    required this.animationMillisecondsDuration,
  }) : super(key: key);
  final Color optionColor;
  final String title;
  final String imageAsset;

  final int animationMillisecondsDuration;

  @override
  State<MainMenuOption> createState() => _MainMenuOptionState();
}

class _MainMenuOptionState extends State<MainMenuOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // Configura a duração e o vsync para a animação
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationMillisecondsDuration),
      vsync: this,
    );

    // Configura a animação de escala (aumento de tamanho)
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Configura a animação de opacidade (fadeIn)
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Inicia a animação quando a tela for construída
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 12,
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: size.height * 0.25,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: widget.optionColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8.0),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                shape: BoxShape.circle),
                            child: Image.asset(
                              'images/${widget.imageAsset}',
                              height: 80,
                              width: 80,
                            )),
                        Text(
                          widget.title,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17),
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
