// cSpell: ignore Camara camara
import 'dart:async';

import 'package:http/http.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputado_frentes.dart';
import 'package:vigia_deputados/models/deputado_orgaos.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/models/frente_response.dart';

class CamaraApi {
  final String url = 'https://dadosabertos.camara.leg.br/api/v2';
  final String deputadosUrl =
      'https://dadosabertos.camara.leg.br/api/v2/deputados?dataInicio=2018-01-01&ordem=ASC&ordenarPor=nome';

  DateTime converterStringParaData(String dataString) {
    List<String> partesData = dataString.split("-");
    int ano = int.parse(partesData[0]);
    int mes = int.parse(partesData[1]);
    int dia = int.parse(partesData[2]);

    return DateTime(ano, mes, dia);
  }

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

  Future<List<DeputadoDespesasDado>> getAllDespesasAno(int deputadoID, int ano) async {
    try {
      List<DeputadoDespesasDado> despesas = [];
      int mesAtual = DateTime.now().month;
      for (int mes = 1; mes <= mesAtual; mes++) {
        DeputadoDespesas response = await getDeputadoDespesasMes(deputadoID, ano, mes);
        despesas.addAll(response.dados);
      }
      despesas.sort(
        ((a, b) {
          if (a.dataDocumento != null && b.dataDocumento != null) {
            return a.dataDocumento!.compareTo(b.dataDocumento!);
          }
          return -1;
        }),
      );

      return despesas;
    } catch (exception) {
      rethrow;
    }
  }

  Future<DeputadoDespesas> getDeputadoDespesasMes(int deputadoID, int ano, int mes) async {
    try {
      String requestUrl = '$url/deputados/$deputadoID/despesas?'
          '&ano=$ano&mes=$mes';
      Response response = await get(Uri.parse(requestUrl));
      return deputadoDespesasFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }

  Future<FrentesResponse> getDeputadoFrentes(int deputadoID) async {
    try {
      String requestUrl = '$url/deputados/$deputadoID/frentes';

      Response response = await get(Uri.parse(requestUrl));
      return frentesResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }

  Future<OrgaosResponse> getDeputadoOrgaos(int deputadoID) async {
    try {
      String requestUrl = '$url/deputados/$deputadoID/orgaos';

      Response response = await get(Uri.parse(requestUrl));
      return orgaosResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }

  Future<FrenteResponse> getFrente(int frenteID) async {
    try {
      String requestUrl = '$url/frentes/$frenteID';

      Response response = await get(Uri.parse(requestUrl));
      return frenteResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }
}
