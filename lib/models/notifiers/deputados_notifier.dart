import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class DeputadoNotifier extends ChangeNotifier {
  final CamaraApi _api = CamaraApi();
  DeputadosResponse? deputados;
  dynamic fetchDeputadosException;
  Future<void> fetchDeputados() async {
    try {
      deputados = await _api.getDeputados();
    } catch (exception) {
      fetchDeputadosException = exception;
    } finally {
      notifyListeners();
    }
  }
}
