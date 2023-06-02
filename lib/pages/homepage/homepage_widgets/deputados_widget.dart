import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class DeputadosWidget extends StatefulWidget {
  const DeputadosWidget({Key? key}) : super(key: key);

  @override
  State<DeputadosWidget> createState() => _DeputadosWidgetState();
}

class _DeputadosWidgetState extends State<DeputadosWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.35,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              border: Border.all(color: ColorLib.darkBlue.color, width: 3),
              image: const DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/camara.png')),
              shape: BoxShape.circle,
              color: ColorLib.darkBlue.color),
        ),
        Text(
          'Deputados',
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
