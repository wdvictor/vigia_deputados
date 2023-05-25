import 'dart:ui';

import 'package:flutter/material.dart';
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
                  image: AssetImage('images/background.jpg'))),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.2),
            width: size.width,
            height: size.height,
            child: Column(children: [
              const Spacer(),
              SizedBox(
                height: size.height * 0.4,
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
              const Spacer(
                flex: 2,
              )
            ]),
          ),
        ),
      ],
    ));
  }
}
