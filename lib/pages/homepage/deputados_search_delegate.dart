import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/homepage/deputado_list_card.dart';
import 'package:vigia_deputados/services/cache.dart';

class DeputadoSearchDelegete extends SearchDelegate {
  List<DeputadoDado> listaDeDeputados;
  final cache = Cache();
  bool reload = false;
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
    return FutureBuilder<Set<String>>(
        future: cache.getFavorites(),
        builder: (context, snapshot) {
          final ids = snapshot.data;
          print(ids);
          return ListView.builder(
              itemCount: resultado.length,
              itemBuilder: (context, index) => DeputadoListCard(
                  isFavorite: ids?.contains(resultado[index].id.toString()),
                  favorite: () => cache.favorite(
                      resultado[index], ids?.contains(resultado[index].id.toString())),
                  deputado: resultado[index]));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<DeputadoDado> resultado = listaDeDeputados
        .where((element) => element.nome.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return FutureBuilder<Set<String>>(
        future: cache.getFavorites(),
        builder: (context, snapshot) {
          final ids = snapshot.data;

          return ListView.builder(
              itemCount: resultado.length,
              itemBuilder: (context, index) => DeputadoListCard(
                  isFavorite: ids?.contains(resultado[index].id.toString()),
                  favorite: () {
                    cache.favorite(resultado[index], ids?.contains(resultado[index].id.toString()));
                  },
                  deputado: resultado[index]));
        });
  }
}
