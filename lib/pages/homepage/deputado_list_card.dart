import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class DeputadoListCard extends StatelessWidget {
  const DeputadoListCard({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDado deputado;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 100,
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.network(deputado.urlFoto),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      deputado.nome,
                      style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text('${deputado.siglaPartido}-${deputado.siglaUf}')
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
