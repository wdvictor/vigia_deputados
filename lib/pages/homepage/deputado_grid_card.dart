import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_deputado.dart';

class DeputadoGridCard extends StatelessWidget {
  const DeputadoGridCard({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDado deputado;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PerfilDeputado(deputadoID: deputado.id),
        ),
      ),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(deputado.urlFoto),
            ),
            Text(
              deputado.nome,
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${deputado.siglaPartido}-${deputado.siglaUf}',
              style: GoogleFonts.dmSans(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
