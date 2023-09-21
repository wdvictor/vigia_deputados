// cSpell: ignore Camara camara
import 'dart:async';

import 'package:http/http.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class CamaraApi {
  final String url = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?dataInicio=2018-01-01&ordem=ASC&ordenarPor=nome';

  Future<DeputadosResponse> getDeputados() async {
    try {
      Response response = await get(Uri.parse('$url/deputados'))
          .timeout(const Duration(seconds: 30), onTimeout: () {
        throw TimeoutException('Esta requesição demorou de mais');
      });

      return deputadosResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }

  Future<DeputadoDetalhadoResponse> getDeputadoInfo(int deputadoID) async {
    try {
      Response response = await get(Uri.parse('$url/deputados/$deputadoID'));
      return deputadoDetalhadoResponseFromJson(
        response.body,
      );
    } catch (exception) {
      rethrow;
    }
  }

  Future<DeputadoDespesas> getDeputadoDespesas(int deputadoID, int ano) async {
    try {
      String requestUrl = '$url/deputados/$deputadoID/despesas?'
          'itens=10000&ordem=DESC&ano=$ano';

      Response response = await get(Uri.parse(requestUrl));
      return deputadoDespesasFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }
}
