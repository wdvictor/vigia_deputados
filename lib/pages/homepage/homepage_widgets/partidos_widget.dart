import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

class PartidosWidget extends StatefulWidget {
  const PartidosWidget({Key? key, required this.animationMilliseconds})
      : super(key: key);
  final int animationMilliseconds;
  @override
  State<PartidosWidget> createState() => _PartidosWidgetState();
}

class _PartidosWidgetState extends State<PartidosWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.27,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 90,
            width: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'images/flag_partido.png',
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorLib.pinkBrown.color,
                  ),
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => ColorLib.greyPink.color,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Visualizar Partidos',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
