import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class ProposicoesWidget extends StatelessWidget {
  const ProposicoesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 30),
      width: size.width * 0.45,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: ColorLib.darkBlue.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Proposições',
        style: GoogleFonts.montserrat(
            color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
