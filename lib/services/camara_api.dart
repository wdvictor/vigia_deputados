// cSpell: ignore Camara camara
import 'dart:convert';

import 'package:http/http.dart';

import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/models/partidos_response.dart';

class CamaraApi {
  final String url = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?dataInicio=2018-01-01&ordem=ASC&ordenarPor=nome';

  DeputadosResponse? deputadosResponseCache;

  Future<DeputadosResponse> getDeputados(
      {List<String>? ufs, bool forceRequest = false}) async {
    try {
      /// It's make this way to not call the api constantly
      if (deputadosResponseCache == null || forceRequest) {
        Response response = await get(Uri.parse('$url/'));
        deputadosResponseCache = deputadosResponseFromJson(
          jsonEncode(response.body),
        );
      }
      return deputadosResponseCache!;
    } catch (exception) {
      rethrow;
    }
  }

  DeputadoDetalhadoResponse? deputadoDetalhadoResponseCache;
  Future<DeputadoDetalhadoResponse> getDeputadoInfo(int deputadoID) async {
    try {
      if (deputadoDetalhadoResponseCache == null) {
        String requestUrl =
            'https://dadosabertos.camara.leg.br/api/v2/deputados';

        Response response = await get(Uri.parse('$requestUrl/$deputadoID'));
        deputadoDetalhadoResponseCache = deputadoDetalhadoResponseFromJson(
          jsonEncode(response.body),
        );
      }

      return deputadoDetalhadoResponseCache!;
    } catch (exception) {
      rethrow;
    }
  }

  DeputadoDespesas? deputadoDespesas;
  Future<DeputadoDespesas> getDeputadoDespesas(int deputadoID) async {
    try {
      if (deputadoDespesas == null) {
        String requestUrl =
            'https://dadosabertos.camara.leg.br/api/v2/deputados'
            '/$deputadoID/despesas?itens=10000&ordem=DESC';

        Response response = await get(Uri.parse(requestUrl));
        deputadoDespesas = deputadoDespesasFromJson(jsonEncode(response.body));
      }
      return deputadoDespesas!;
    } catch (exception) {
      rethrow;
    }
  }

  PartidosResponse? partidosResponseCache;
  Future<PartidosResponse> getPartidos({int pag = 1}) async {
    try {
      if (partidosResponseCache == null) {
        Response response = await get(Uri.parse('$url/partidos'));
        partidosResponseCache = partidosResponseFromJson(response.body);
        return partidosResponseCache!;
      } else {
        return partidosResponseCache!;
      }
    } catch (exception) {
      rethrow;
    }
  }
}
