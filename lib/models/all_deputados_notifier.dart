import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class AllDeputadosNotifier extends ChangeNotifier {
  final CamaraApi _api = CamaraApi();
  DeputadosResponse? allDeputadosResponse;
  int currentPage;
  AllDeputadosNotifier({required this.currentPage});
  void changePage(int page) async {
    currentPage = page;
    getDeputados();
  }

  Future<void> getDeputados() async {
    log('calling getDeputados notifier');
    allDeputadosResponse = await _api.getDeputados(page: currentPage);
    notifyListeners();
  }
}
