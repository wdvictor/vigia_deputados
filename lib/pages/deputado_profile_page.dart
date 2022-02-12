//cSpell:ignore cupertino camara
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class DeputadoProfilePage extends StatefulWidget {
  const DeputadoProfilePage({Key? key, required this.deputadoDados})
      : super(key: key);
  final Dado deputadoDados;

  @override
  _DeputadoProfilePageState createState() => _DeputadoProfilePageState();
}

class _DeputadoProfilePageState extends State<DeputadoProfilePage> {
  late CamaraApi _camaraApi;

  @override
  void initState() {
    super.initState();
    _camaraApi = CamaraApi();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.transparent,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'DEP-${widget.deputadoDados.id}',
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Material(
                          shape: const CircleBorder(),
                          elevation: 12,
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorLib.green.color, width: 6)),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ColorLib.blue.color, width: 5),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    widget.deputadoDados.urlFoto,
                                    scale: 10),
                                radius: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Nome:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Partido:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'UF:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.deputadoDados.nome,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    widget.deputadoDados.siglaPartido,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    widget.deputadoDados.siglaUf,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: FutureBuilder<DeputadoDetalhadoResponse>(
                  future: _camaraApi.getDeputadoInfo(widget.deputadoDados.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    DeputadoDetalhadoResponse deputadoInfo = snapshot.data!;
                    return CustomScrollView(
                      slivers: [
                        SliverGrid.count(
                          crossAxisCount: 2,
                          children: [],
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
