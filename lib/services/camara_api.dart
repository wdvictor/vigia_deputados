// cSpell: ignore Camara camara
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class CamaraApi {
  final String dadosAbertosUrl = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome';

  DeputadosResponse? deputadosResponse;

  Future<DeputadosResponse> getDeputados() async {
    try {
      /// It's make this way to not call the api constantly
      if (deputadosResponse == null) {
        log('Deputados CALL', name: 'REQUEST');
        Response response = await Dio().get(deputadosUrl);
        deputadosResponse =
            deputadosResponseFromJson(jsonEncode(response.data));
        return deputadosResponse!;
      } else {
        return deputadosResponse!;
      }
    } catch (exception) {
      rethrow;
    }
  }
}
