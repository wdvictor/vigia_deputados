import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/dados_gerais_tab/tab_dados_gerais.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/tab_despesas.dart';
import 'package:vigia_deputados/pages/perfil_deputado/frentes_tab/frentes_tab.dart';
import 'package:vigia_deputados/pages/perfil_deputado/notas_fiscais_tab/notas_fiscais_tab.dart';
import 'package:vigia_deputados/pages/perfil_deputado/orgaos_tab.dart/orgaos_tab.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_deputado_error_page.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_header.dart';
import 'package:vigia_deputados/services/camara_api.dart';
import 'package:vigia_deputados/services/device_info.dart';

class PerfilDeputado extends StatefulWidget {
  const PerfilDeputado({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  State<PerfilDeputado> createState() => _PerfilDeputadoState();
}

class _PerfilDeputadoState extends State<PerfilDeputado> with SingleTickerProviderStateMixin {
  final CamaraApi _api = CamaraApi();
  late TabController _tabController;
  bool _retryGetInfo = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.primaryColor.color,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List>(
        future: Future.wait(
          [
            _api.getDeputadoInfo(widget.deputadoID),
            _api.getAllDespesasAno(widget.deputadoID, DateTime.now().year),
          ],
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return PerfilDeputadoError(
              callback: () => setState(() => _retryGetInfo = !_retryGetInfo),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final DeputadoDetalhadoResponse deputado = snapshot.data!.first;
          final List<DeputadoDespesasDado> desputadoDespesas = snapshot.data!.last;

          return Column(
            children: [
              PerfilHeader(
                deputado: deputado.dados,
              ),
              TabBar(
                  controller: _tabController,
                  labelStyle: GoogleFonts.dmSans(color: Colors.black, fontSize: isTablet ? 23 : 15),
                  indicatorColor: ColorLib.primaryColor.color,
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: 'Dados Pessoais',
                    ),
                    Tab(text: 'Despesas'),
                    Tab(text: 'Notas fiscais'),
                    Tab(text: 'Frentes'),
                    Tab(text: 'Órgãos Participantes'),
                  ]),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TabDadosGerais(deputado: deputado.dados),
                    TabDespesas(
                      despesasDados: desputadoDespesas,
                    ),
                    TabNotasFiscais(
                      despesasDados: desputadoDespesas,
                    ),
                    TabFrentes(deputadoID: deputado.dados.id),
                    TabOrgaos(deputadoID: deputado.dados.id),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
