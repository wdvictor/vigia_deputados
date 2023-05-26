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
      margin: const EdgeInsets.only(top: 30),
      width: size.width * 0.45,
      height: size.height * 0.05,
      decoration: BoxDecoration(
        color: ColorLib.greyPink.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Proposições',
            style: GoogleFonts.montserrat(
                color: ColorLib.pinkBrown.color, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.arrow_forward,
            color: ColorLib.pinkBrown.color,
          )
        ],
      ),
    );
  }
}
