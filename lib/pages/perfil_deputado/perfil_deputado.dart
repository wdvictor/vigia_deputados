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
      body: FutureBuilder<DeputadoDetalhadoResponse>(
        future: _api.getDeputadoInfo(widget.deputadoID),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final DeputadoDetalhadoDado deputado = snapshot.data!.dados;
          return FutureBuilder<List<DeputadoDespesasDado>>(
              future: _api.getAllDespesasAno(deputado.id, DateTime.now().year),
              builder: (context, despesasSnapshot) {
                if (!despesasSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    PerfilHeader(
                      deputado: deputado,
                    ),
                    TabBar(
                        controller: _tabController,
                        labelStyle:
                            GoogleFonts.dmSans(color: Colors.black, fontSize: isTablet ? 23 : 15),
                        indicatorColor: ColorLib.primaryColor.color,
                        labelColor: Colors.black,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Dados Pessoais',
                          ),
                          Tab(text: 'Despesas'),
                          Tab(text: 'Notas fiscais'),
                          Tab(text: 'Órgãos Participantes'),
                          Tab(text: 'Frentes'),
                        ]),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          TabDadosGerais(deputado: deputado),
                          TabDespesas(
                            despesasDados: despesasSnapshot.data!,
                          ),
                          TabNotasFiscais(
                            despesasDados: despesasSnapshot.data!,
                          ),
                          TabOrgaos(deputadoID: deputado.id),
                          TabFrentes(deputadoID: deputado.id),
                        ],
                      ),
                    )
                  ],
                );
              });
        }),
      ),
    );
  }
}
