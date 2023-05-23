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
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            'Vigia Deputados',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainMenuOption(
              title: 'Partidos',
              imageAsset: 'lime-flag-1.png',
              animationMillisecondsDuration: 250,
              callback: () {},
            ),
            MainMenuOption(
              title: 'Deputados',
              imageAsset: 'clip-politician-1.png',
              animationMillisecondsDuration: 500,
              callback: () {},
            ),
            MainMenuOption(
              title: 'Proposições',
              imageAsset: 'congresswoman.png',
              animationMillisecondsDuration: 750,
              callback: () {},
            ),
            MainMenuOption(
              title: 'Votações',
              imageAsset: 'urban-online-voting.png',
              animationMillisecondsDuration: 1000,
              callback: () {},
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
    required this.callback,
  }) : super(key: key);

  final String title;
  final String imageAsset;
  final VoidCallback callback;
  final int animationMillisecondsDuration;

  @override
  State<MainMenuOption> createState() => _MainMenuOptionState();
}

class _MainMenuOptionState extends State<MainMenuOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late bool _isTapped = false;

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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onHighlightChanged: (value) {
          setState(() {
            _isTapped = value;
          });
        },
        onTap: () {},
        child: AnimatedBuilder(
            animation: _controller,
            builder: (context, snapshot) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isTapped ? 70 : 100,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: ColorLib.darkBlue.color, width: 1.5)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              padding: const EdgeInsets.all(8.0),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorLib.darkBlue.color, width: 3),
                                  shape: BoxShape.circle),
                              child: Image.asset(
                                'images/${widget.imageAsset}',
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.title,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 17),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorLib.darkBlue.color,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
