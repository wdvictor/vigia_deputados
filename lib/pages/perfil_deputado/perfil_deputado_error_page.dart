import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class PerfilDeputadoError extends StatelessWidget {
  const PerfilDeputadoError({Key? key, required this.callback}) : super(key: key);
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/urban-error-404.png')),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Um erro aconteceu, não foi possível pegar as informações do deputado.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          GestureDetector(
            onTap: callback,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: ColorLib.primaryColor.color),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Tentar de novo',
                    style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Icon(
                    Icons.replay_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
