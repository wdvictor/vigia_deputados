import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputado_frentes.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class TabFrentes extends StatelessWidget {
  const TabFrentes({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FrentesResponse>(
      future: CamaraApi().getDeputadoFrentes(deputadoID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<FrentesDado> dados = snapshot.data!.dados;
        return ListView.builder(
          itemCount: dados.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        dados[index].titulo,
                        style: GoogleFonts.dmSans(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
