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
            const MainMenuOption(
              title: 'Partidos',
              imageAsset: 'lime-flag-1.png',
              animationMillisecondsDuration: 250,
            ),
            const MainMenuOption(
              title: 'Deputados',
              imageAsset: 'clip-politician-1.png',
              animationMillisecondsDuration: 500,
            ),
            const MainMenuOption(
              title: 'Proposições',
              imageAsset: 'congresswoman.png',
              animationMillisecondsDuration: 750,
            ),
            const MainMenuOption(
              title: 'Votações',
              imageAsset: 'urban-online-voting.png',
              animationMillisecondsDuration: 1000,
            ),
          ],
        ));
  }
}

class MainMenuOption extends StatefulWidget {
  const MainMenuOption({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.animationMillisecondsDuration,
  }) : super(key: key);

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
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorLib.darkBlue.color,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: const EdgeInsets.all(8.0),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 3),
                              shape: BoxShape.circle),
                          child: Image.asset(
                            'images/${widget.imageAsset}',
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.title,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 17),
                        ),
                        const Spacer(),
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
