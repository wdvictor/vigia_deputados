import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class TabNotasFiscais extends StatefulWidget {
  const TabNotasFiscais({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;

  @override
  State<TabNotasFiscais> createState() => _TabNotasFiscaisState();
}

class _TabNotasFiscaisState extends State<TabNotasFiscais> {
  final CamaraApi _camaraApi = CamaraApi();

  String formatDate(DateTime date) {
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
    return FutureBuilder<DeputadoDespesas>(
        future: _camaraApi.getDeputadoDespesas(widget.deputadoID),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DeputadoDespesasDado> dados = snapshot.data!.dados;
          return ListView.builder(
            itemCount: dados.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 120,
                decoration: const BoxDecoration(),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.doc),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dados[index].nomeFornecedor.toLowerCase(),
                              style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dados[index].tipoDespesa.toLowerCase(),
                              style: GoogleFonts.dmSans(color: Colors.grey[600]),
                            ),
                            Text(formatDate(dados[index].dataDocumento))
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        }));
  }
}
