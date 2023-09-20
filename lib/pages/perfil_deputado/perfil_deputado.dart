import 'package:flutter/material.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_header.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class PerfilDeputado extends StatefulWidget {
  const PerfilDeputado({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  State<PerfilDeputado> createState() => _PerfilDeputadoState();
}

class _PerfilDeputadoState extends State<PerfilDeputado> {
  final CamaraApi _api = CamaraApi();

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

          var deputado = snapshot.data!.dados;
          return Column(
            children: [
              PerfilHeader(
                deputado: deputado,
              ),
            ],
          );
        }),
      ),
    );
  }
}
