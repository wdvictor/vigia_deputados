import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/pages/perfil_deputado/notas_fiscais_tab/nota_fiscal_widget.dart';

class NotasFiscaisSearchDelegate extends SearchDelegate {
  List<DeputadoDespesasDado> despesasDados;

  NotasFiscaisSearchDelegate(this.despesasDados);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<DeputadoDespesasDado> resultado = despesasDados
        .where(
          (element) => element.nomeFornecedor.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: resultado.length,
      itemBuilder: (context, index) => NotaFiscalWidget(
        notaFiscal: resultado[index],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DeputadoDespesasDado> resultado = despesasDados
        .where(
          (element) => element.nomeFornecedor.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: resultado.length,
      itemBuilder: (context, index) => NotaFiscalWidget(
        notaFiscal: resultado[index],
      ),
    );
  }
}
