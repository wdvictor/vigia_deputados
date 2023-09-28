import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/frente_response.dart';

class CoordenadorHeader extends StatelessWidget {
  const CoordenadorHeader({
    Key? key,
    required this.dadosFrente,
  }) : super(key: key);

  final Dados dadosFrente;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(dadosFrente.coordenador.urlFoto),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dadosFrente.coordenador.nome,
                style: GoogleFonts.dmSans(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${dadosFrente.coordenador.siglaPartido}-${dadosFrente.coordenador.siglaUf}',
                style: GoogleFonts.dmSans(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}
