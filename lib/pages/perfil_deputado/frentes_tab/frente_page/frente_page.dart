import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/frente_response.dart';
import 'package:vigia_deputados/pages/perfil_deputado/data_field.dart';
import 'package:vigia_deputados/pages/perfil_deputado/frentes_tab/frente_page/coordenador_header.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class FrentePage extends StatefulWidget {
  const FrentePage({Key? key, required this.frenteID}) : super(key: key);
  final int frenteID;
  @override
  State<FrentePage> createState() => _FrentePageState();
}

class _FrentePageState extends State<FrentePage> {
  final CamaraApi _camaraApi = CamaraApi();
  double _expandedHeight = 250.0;
  late bool _showCoordenadorField;
  late Future<FrenteResponse> _frenteFuture;

  @override
  void initState() {
    super.initState();
    _frenteFuture = _camaraApi.getFrente(widget.frenteID);
    _showCoordenadorField = false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.primaryColor.color,
      ),
      body: FutureBuilder<FrenteResponse>(
        future: _frenteFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var dadosFrente = snapshot.data!.dados;
          return Stack(
            children: [
              Positioned(
                child: Column(
                  children: [
                    DataField(title: 'Título', data: dadosFrente.titulo),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: ColorLib.dataFieldColor.color,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Situação',
                            style: GoogleFonts.dmSans(fontSize: 15, color: Colors.grey[700]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            dadosFrente.situacao,
                            style: GoogleFonts.dmSans(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                    ),
                    DataField(
                      title: 'Telefone',
                      data: dadosFrente.telefone,
                      showCopyButton: true,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      if (_expandedHeight > 200) {
                        _expandedHeight -= details.primaryDelta!;
                      }
                      _showCoordenadorField = _expandedHeight > 250;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _expandedHeight,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorLib.primaryColor.color,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: 25,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Coordenador',
                            style: GoogleFonts.dmSans(
                                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Divider(
                          endIndent: 20,
                          indent: 20,
                          color: Colors.white,
                          thickness: 1,
                        ),
                        CoordenadorHeader(dadosFrente: dadosFrente),
                        Visibility(
                          visible: _showCoordenadorField,
                          child: DataField(
                            title: 'Email',
                            data: dadosFrente.email,
                            showCopyButton: true,
                          ),
                        ),
                        Visibility(
                          visible: _showCoordenadorField,
                          child: DataField(
                            title: 'Email',
                            data: dadosFrente.telefone,
                            showCopyButton: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
