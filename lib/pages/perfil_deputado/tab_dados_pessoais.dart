import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/data_field.dart';

class TabDadosPessoais extends StatelessWidget {
  const TabDadosPessoais({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDetalhadoDado deputado;

  String formatDateString(String inputDate) {
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final outputFormat = DateFormat('dd/MM/yyyy');
    final date = inputFormat.parse(inputDate);
    return outputFormat.format(date);
  }

  String formatCellphone(String? cellphone) {
    if (cellphone == null) {
      return '';
    }
    return '(61) $cellphone';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          DataField(
            title: 'Data Nascimento',
            data: formatDateString(
              deputado.dataNascimento.toString(),
            ),
          ),
          DataField(title: 'Escolaridade', data: deputado.escolaridade),
          DataField(title: 'Município de nascimento', data: deputado.municipioNascimento),
          DataField(title: 'UF de nascimento', data: deputado.ufNascimento),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Gabinete',
              style:
                  GoogleFonts.dmSans(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
            color: Colors.grey,
          ),
          DataField(title: 'Gabinete', data: deputado.ultimoStatus.gabinete.sala ?? ''),
          DataField(title: 'Anexo', data: deputado.ultimoStatus.gabinete.predio ?? ''),
          DataField(title: 'Andar', data: deputado.ultimoStatus.gabinete.andar ?? ''),
          DataField(
            title: 'Telefone',
            data: formatCellphone(deputado.ultimoStatus.gabinete.telefone),
            showCopyButton: true,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Dados Eleitorais',
              style:
                  GoogleFonts.dmSans(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          const Divider(
            endIndent: 20,
            indent: 20,
            color: Colors.grey,
          ),
          DataField(title: 'Condição eleitoral', data: deputado.ultimoStatus.condicaoEleitoral),
          DataField(title: 'Situação', data: deputado.ultimoStatus.situacao),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
