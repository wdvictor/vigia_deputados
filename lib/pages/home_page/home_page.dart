// cSpell: ignore Camara camara cupertino

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/home_page/action_sheet.dart';
import 'package:vigia_deputados/pages/home_page/filtrar_uf_options.dart';
import 'package:vigia_deputados/pages/profile/deputado_profile_page.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CamaraApi _camaraApi;
  late Size _size;
  late List<String> _ufsSelecionadas;

  @override
  void initState() {
    super.initState();
    _camaraApi = CamaraApi();
    _ufsSelecionadas = [];
  }

  @override
  Widget build(BuildContext context) {
    log(_ufsSelecionadas.toString());
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
          middle: Text(
            'Vigia Deputados',
            style: TextStyle(
              color: CupertinoColors.systemBlue,
            ),
          ),
          leading: Icon(CupertinoIcons.settings,
              color: CupertinoColors.systemBlue, size: 20),
        ),
        child: FutureBuilder<DeputadosResponse>(
          future: _camaraApi.getDeputados(),
          builder: (BuildContext context,
              AsyncSnapshot<DeputadosResponse> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            double axisSpacing = _size.height * 0.01;
            List<DeputadoDado> dados = snapshot.data!.dados;

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: CupertinoButton(
                              onPressed: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) => MenuActionSheet(
                                    ufsSelecionadas:
                                        (List<String> ufsSelecionadas) {
                                      setState(() {
                                        _ufsSelecionadas = ufsSelecionadas;
                                      });
                                    },
                                    alreadySelectedUfs:
                                        _ufsSelecionadas.isNotEmpty
                                            ? _ufsSelecionadas
                                            : null,
                                  ),
                                );
                              },
                              child: const Icon(
                                  CupertinoIcons.line_horizontal_3_decrease),
                            )),
                            const Expanded(
                              flex: 5,
                              child: CupertinoSearchTextField(
                                placeholder: 'Buscar',
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: 1),
                  ),
                  SliverGrid.count(
                    mainAxisSpacing: axisSpacing,
                    crossAxisSpacing: axisSpacing,
                    crossAxisCount: 2,
                    children: [
                      for (final DeputadoDado dado in dados)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    DeputadoProfilePage(deputado: dado),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                              elevation: 10,
                              color: CupertinoColors
                                  .tertiarySystemGroupedBackground,
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Material(
                                        shape: const CircleBorder(),
                                        elevation: 11,
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          height: _size.height * 0.13,
                                          child: Hero(
                                            tag: 'DEP-${dado.id}',
                                            child: CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(dado.urlFoto),
                                              radius: 45,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          dado.nome,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints:
                                            const BoxConstraints.expand(),
                                        color: ColorLib.green.color,
                                        child: Text(
                                            '${dado.siglaPartido}-${dado.siglaUf}'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
