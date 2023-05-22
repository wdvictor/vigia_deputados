// cSpell: ignore Camara camara
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class CamaraApi {
  final String dadosAbertosUrl = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?dataInicio=2018-01-01&ordem=ASC&ordenarPor=nome';

  DeputadosResponse? deputadosResponse;
  DeputadoDetalhadoResponse? deputadoDetalhadoResponse;

  ///
  ///CA-GD-00
  Future<DeputadosResponse> getDeputados(
      {List<String>? ufs, bool forceRequest = false}) async {
    try {
      /// It's make this way to not call the api constantly
      if (deputadosResponse == null || forceRequest) {
        log('', name: 'CALLING DEPUTADOS API');
        log('Deputados CALL', name: 'REQUEST');

        Response response = await get(Uri.parse('$dadosAbertosUrl/'));
        deputadosResponse = deputadosResponseFromJson(
          jsonEncode(response.body),
        );
      }
      return deputadosResponse!;
    } catch (exception) {
      rethrow;
    }
  }

  //CA-GDI-00
  Future<DeputadoDetalhadoResponse> getDeputadoInfo(int deputadoID) async {
    try {
      if (deputadoDetalhadoResponse == null) {
        log('', name: 'CALLING DEPUTADO API');
        String requestUrl =
            'https://dadosabertos.camara.leg.br/api/v2/deputados';

        Response response = await get(Uri.parse('$requestUrl/$deputadoID'));
        deputadoDetalhadoResponse = deputadoDetalhadoResponseFromJson(
          jsonEncode(response.body),
        );
      }

      return deputadoDetalhadoResponse!;
    } catch (exception) {
      rethrow;
    }
  }

  //CA-GDD-02
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
}
