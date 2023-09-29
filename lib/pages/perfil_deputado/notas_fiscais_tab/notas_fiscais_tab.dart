import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/pages/perfil_deputado/notas_fiscais_tab/nota_fiscal_widget.dart';
import 'package:vigia_deputados/pages/perfil_deputado/notas_fiscais_tab/notas_fiscais_search_delegate.dart';

class TabNotasFiscais extends StatefulWidget {
  const TabNotasFiscais({Key? key, required this.despesasDados}) : super(key: key);

  final List<DeputadoDespesasDado> despesasDados;
  @override
  State<TabNotasFiscais> createState() => _TabNotasFiscaisState();
}

class _TabNotasFiscaisState extends State<TabNotasFiscais> {
  @override
  Widget build(BuildContext context) {
    widget.despesasDados.sort((a, b) {
      if (a.dataDocumento == null || b.dataDocumento == null) {
        return -1;
      }
      return a.dataDocumento!.compareTo(b.dataDocumento!);
    });
    final data = widget.despesasDados.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: NotasFiscaisSearchDelegate(data)),
            icon: const Icon(Icons.search)),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return NotaFiscalWidget(notaFiscal: data[index]);
            }),
          ),
        ),
      ],
    );
  }
}
