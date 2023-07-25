// cSpell: ignore Camara camara
import 'dart:convert';

import 'package:http/http.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class CamaraApi {
  final String url = 'https://dadosabertos.camara.leg.br/api/v2';

  Future<DeputadosResponse> getDeputados({required int page}) async {
    try {
      Response response = await get(Uri.parse('$url/deputados'));
      return deputadosResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }

  Future<DeputadoDetalhadoResponse> getDeputadoInfo(int deputadoID) async {
    try {
      Response response = await get(Uri.parse('$url/deputados/$deputadoID'));
      return deputadoDetalhadoResponseFromJson(
        jsonEncode(response.body),
      );
    } catch (exception) {
      rethrow;
    }
  }

  DeputadoDespesas? deputadoDespesas;
  Future<DeputadoDespesas> getDeputadoDespesas(int deputadoID) async {
    try {
      if (deputadoDespesas == null) {
        String requestUrl = 'https://dadosabertos.camara.leg.br/api/v2/deputados'
            '/$deputadoID/despesas?itens=10000&ordem=DESC';

        Response response = await get(Uri.parse(requestUrl));
        deputadoDespesas = deputadoDespesasFromJson(jsonEncode(response.body));
      }
      return deputadoDespesas!;
    } catch (exception) {
      rethrow;
    }
  }
}
