// cSpell: ignore Camara camara
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class CamaraApi {
  final String dadosAbertosUrl = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome';

  DeputadosResponse? deputadosResponse;
  DeputadoDetalhadoResponse? deputadoDetalhadoResponse;

  //CA-GD-00
  Future<DeputadosResponse> getDeputados() async {
    try {
      /// It's make this way to not call the api constantly
      if (deputadosResponse == null) {
        log('Deputados CALL', name: 'REQUEST');
        Response response = await Dio().get(deputadosUrl);
        deputadosResponse = deputadosResponseFromJson(
          jsonEncode(response.data),
        );
      }
      return deputadosResponse!;
    } catch (exception) {
      throw 'CA-GDI-00';
    }
  }

  //CA-GDI-00
  Future<DeputadoDetalhadoResponse> getDeputadoInfo(int deputadoID) async {
    try {
      if (deputadoDetalhadoResponse == null) {
        String requestUrl =
            'https://dadosabertos.camara.leg.br/api/v2/deputados';

        Response response = await Dio().get('$requestUrl/$deputadoID');
        deputadoDetalhadoResponse = deputadoDetalhadoResponseFromJson(
          jsonEncode(response.data),
        );
      }

      return deputadoDetalhadoResponse!;
    } catch (exception) {
      log('', name: 'ERROR', error: exception);
      throw 'CA-GDI-01';
    }
  }
}
