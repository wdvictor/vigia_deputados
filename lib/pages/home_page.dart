// cSpell: ignore Camara camara cupertino

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CamaraApi _camaraApi;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _camaraApi = CamaraApi();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final double _axisSpacing = _size.width * 0.05;
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
                child: CircularProgressIndicator(),
              );
            }

            return GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              crossAxisCount: 2,
              crossAxisSpacing: _axisSpacing,
              mainAxisSpacing: _axisSpacing,
              children: [
                for (final Dado dado in snapshot.data!.dados)
                  Material(
                    elevation: 10,
                    color: CupertinoColors.tertiarySystemGroupedBackground,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: _size.height * 0.009,
                          ),
                          Material(
                            elevation: 11,
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                height: _size.height * 0.13,
                                child: Image.network(dado.urlFoto)),
                          ),
                          Expanded(child: Center(child: Text(dado.nome))),
                          Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints.expand(),
                                color: ColorLib.green.color,
                                child: Text(dado.siglaPartido)),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
