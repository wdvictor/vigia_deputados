import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_header.dart';
import 'package:vigia_deputados/pages/perfil_deputado/tab_dados_pessoais.dart';
import 'package:vigia_deputados/services/camara_api.dart';

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          return Column(
            children: [
              PerfilHeader(
                deputado: deputado,
              ),
              TabBar(
                  controller: _tabController,
                  labelStyle: GoogleFonts.dmSans(color: Colors.black),
                  indicatorColor: ColorLib.primaryColor.color,
                  labelColor: Colors.black,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      text: 'Dados Pessoais',
                    ),
                    Tab(text: 'Despesas'),
                    Tab(text: 'Órgãos Participantes'),
                    Tab(text: 'Frentes'),
                  ]),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    TabDadosPessoais(deputado: deputado),
                    const Center(child: Text('Conteúdo de Despesas')),
                    const Center(child: Text('Conteúdo de Órgãos Participantes')),
                    const Center(child: Text('Conteúdo de Frentes')),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
