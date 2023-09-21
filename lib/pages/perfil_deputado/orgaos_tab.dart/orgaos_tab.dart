import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputado_orgaos.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class TabOrgaos extends StatelessWidget {
  const TabOrgaos({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;

  String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    String dia = date.day.toString();
    String mes = date.month.toString();
    int ano = date.year;
    if (dia.length == 1) {
      dia = '0$dia';
    }
    if (mes.length == 1) {
      mes = '0$mes';
    }

    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrgaosResponse>(
      future: CamaraApi().getDeputadoOrgaos(deputadoID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<OrgaosDado> dados = snapshot.data!.dados;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dados[index].titulo,
                              style: GoogleFonts.dmSans(color: Colors.grey[600]),
                            ),
                            Text(
                              formatDate(dados[index].dataInicio),
                              style: GoogleFonts.dmSans(color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      Text(
                        dados[index].siglaOrgao,
                        style: GoogleFonts.dmSans(
                            color: Colors.grey[800], fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        dados[index].nomeOrgao,
                        style: GoogleFonts.dmSans(color: Colors.grey[800]),
                      ),
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
