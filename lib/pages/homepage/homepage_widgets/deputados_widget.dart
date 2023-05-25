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
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: const DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/camara.png')),
              shape: BoxShape.circle,
              color: ColorLib.greyPink.color),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
          ),
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
