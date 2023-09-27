import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/services/device_info.dart';

class TabNotasFiscais extends StatefulWidget {
  const TabNotasFiscais({Key? key, required this.despesasDados}) : super(key: key);

  final List<DeputadoDespesasDado> despesasDados;
  @override
  State<TabNotasFiscais> createState() => _TabNotasFiscaisState();
}

class _TabNotasFiscaisState extends State<TabNotasFiscais> {
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
    widget.despesasDados.sort((a, b) {
      if (a.dataDocumento == null || b.dataDocumento == null) {
        return -1;
      }
      return a.dataDocumento!.compareTo(b.dataDocumento!);
    });
    final data = widget.despesasDados.reversed.toList();
    final Size size = MediaQuery.of(context).size;
    final isTablet = DeviceInfo.isTablet(context);
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () => launchUrl(Uri.parse(data[index].urlDocumento ?? '')),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: isTablet ? size.height * 0.15 : 120,
              decoration: const BoxDecoration(),
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.doc,
                        size: size.width * 0.05,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].nomeFornecedor.toLowerCase(),
                            style: GoogleFonts.dmSans(
                                fontSize: isTablet ? 20 : 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            data[index].tipoDespesa.toLowerCase(),
                            style: GoogleFonts.dmSans(
                                fontSize: isTablet ? 23 : 15, color: Colors.grey[600]),
                          ),
                          Text(
                            formatDate(data[index].dataDocumento),
                            style: GoogleFonts.dmSans(
                                fontSize: isTablet ? 20 : 15, color: Colors.grey[600]),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: size.width * 0.03,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
