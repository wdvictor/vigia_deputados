import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/homepage/deputado_list_card.dart';

class DeputadoSearchDelegete extends SearchDelegate {
  List<DeputadoDado> listaDeDeputados;

  DeputadoSearchDelegete(this.listaDeDeputados);

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
    List<DeputadoDado> resultado = listaDeDeputados
        .where((element) => element.nome.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: resultado.length,
        itemBuilder: (context, index) => DeputadoListCard(deputado: resultado[index]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DeputadoDado> resultado = listaDeDeputados
        .where((element) => element.nome.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
        itemCount: resultado.length,
        itemBuilder: (context, index) => DeputadoListCard(deputado: resultado[index]));
  }
}
