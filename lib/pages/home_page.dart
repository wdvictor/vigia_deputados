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
                    ),
                    MainMenuOption(
                      optionColor: ColorLib.darkBlue.color,
                      title: 'Deputados',
                      imageAsset: 'clip-politician-1.png',
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
                    ),
                    MainMenuOption(
                      optionColor: ColorLib.darkGreen.color,
                      title: 'Votações',
                      imageAsset: 'urban-online-voting.png',
                    ),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class MainMenuOption extends StatelessWidget {
  const MainMenuOption({
    Key? key,
    required this.optionColor,
    required this.title,
    required this.imageAsset,
  }) : super(key: key);
  final Color optionColor;
  final String title;
  final String imageAsset;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: size.height * 0.25,
          width: size.width * 0.4,
          decoration: BoxDecoration(
            color: optionColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: const EdgeInsets.all(5.0),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      shape: BoxShape.circle),
                  child: Image.asset(
                    'images/$imageAsset',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  )),
              Text(
                title,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
