import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/services/device_info.dart';

class NotaFiscalWidget extends StatelessWidget {
  const NotaFiscalWidget({Key? key, required this.notaFiscal}) : super(key: key);
  final DeputadoDespesasDado notaFiscal;

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
    final isTablet = DeviceInfo.isTablet(context);
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => launchUrl(Uri.parse(notaFiscal.urlDocumento ?? '')),
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
                      notaFiscal.nomeFornecedor.toLowerCase(),
                      style: GoogleFonts.dmSans(
                          fontSize: isTablet ? 20 : 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      notaFiscal.tipoDespesa.toLowerCase(),
                      style:
                          GoogleFonts.dmSans(fontSize: isTablet ? 23 : 15, color: Colors.grey[600]),
                    ),
                    Text(
                      formatDate(notaFiscal.dataDocumento),
                      style:
                          GoogleFonts.dmSans(fontSize: isTablet ? 20 : 15, color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
