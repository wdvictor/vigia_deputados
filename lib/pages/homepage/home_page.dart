import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/pages/homepage/homepage_widgets/deputados_widget.dart';
import 'package:vigia_deputados/pages/homepage/homepage_widgets/partidos_widget.dart';
import 'package:vigia_deputados/pages/homepage/homepage_widgets/proposicoes_widget.dart';
import 'package:vigia_deputados/widgets/animated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/CAMARA_01.jpg'))),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            width: size.width,
            height: size.height,
            child: Column(children: [
              const Spacer(),
              SizedBox(
                height: size.height * 0.3,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      child: PartidosWidget(
                        animationMilliseconds: 250,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnimatedButton(
                            animationMilliseconds: 500,
                            child: DeputadosWidget()),
                        AnimatedButton(
                          animationMilliseconds: 750,
                          child: ProposicoesWidget(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AnimatedButton(
                        animationMilliseconds: 1000,
                        child: MenuOptionButton(
                            title: 'Votações', callback: () {})),
                    AnimatedButton(
                        animationMilliseconds: 1250,
                        child: MenuOptionButton(
                            title: 'Lideres', callback: () {})),
                  ],
                ),
              )
            ]),
          ),
        ),
      ],
    ));
  }
}

class MenuOptionButton extends StatelessWidget {
  const MenuOptionButton(
      {Key? key, required this.title, required this.callback})
      : super(key: key);
  final String title;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 70,
      decoration: BoxDecoration(
          color: ColorLib.darkBlue.color,
          //border: Border.all(color: ColorLib.darkBlue.color, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            title,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
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
