//cSpell:ignore cupertino camara Graficos
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';
import 'package:vigia_deputados/widgets/deputado_header.dart';
import 'package:vigia_deputados/widgets/deputado_info_with_copy.dart';

class DeputadoDespesasPage extends StatefulWidget {
  const DeputadoDespesasPage({Key? key, required this.deputadoDado})
      : super(key: key);
  final DeputadoDado deputadoDado;
  @override
  State<DeputadoDespesasPage> createState() => _DeputadoDespesasPageState();
}

class _DeputadoDespesasPageState extends State<DeputadoDespesasPage> {
  late CamaraApi _camaraApi;

  @override
  void initState() {
    super.initState();
    _camaraApi = CamaraApi();
  }

  late List<Widget> pages = [
    TabGraficos(
      deputadoDado: widget.deputadoDado,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Despesas',
          style: TextStyle(color: CupertinoColors.systemBlue),
        ),
        backgroundColor: Colors.transparent,
      ),
      child: FutureBuilder(
          future: _camaraApi.getDeputadoDespesas(widget.deputadoDado.id),
          builder:
              (BuildContext context, AsyncSnapshot<DeputadoDespesas> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            DeputadoDespesas deputadoDespesas = snapshot.data!;

            return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.doc),
                      label: 'Notas Fiscais',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.graph_square),
                      label: 'Gráficos',
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      switch (index) {
                        case 0:
                          return TabNotasFiscais(
                              deputadoDado: widget.deputadoDado,
                              deputadoDespesas: deputadoDespesas);

                        case 1:
                          return TabGraficos(
                            deputadoDado: widget.deputadoDado,
                          );

                        default:
                      }
                      return pages[index];
                    },
                  );
                });
          }),
    );
  }
}

class DespesaCard extends StatelessWidget {
  const DespesaCard({Key? key, required this.deputadoDespesasDado})
      : super(key: key);
  final DeputadoDespesasDado deputadoDespesasDado;

  String getDocumentoData() {
    int dia = deputadoDespesasDado.dataDocumento.day;
    int mes = deputadoDespesasDado.dataDocumento.month;
    int ano = deputadoDespesasDado.dataDocumento.year;
    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Material(
        elevation: 12,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DeputadoInfoWithCopy(
                  infoName: 'Tipo Despesa',
                  infoValue: deputadoDespesasDado.tipoDespesa == null
                      ? ''
                      : deputadoDespesasDado.tipoDespesa!.name),
              Container(
                color: CupertinoColors.systemGrey6,
                child: DeputadoInfoWithCopy(
                  infoName: 'Fornecedor',
                  infoValue: deputadoDespesasDado.nomeFornecedor,
                  showCopyWidget: true,
                ),
              ),
              DeputadoInfoWithCopy(
                  showCopyWidget: true,
                  infoName: 'CNPJ Fornecedor',
                  infoValue: deputadoDespesasDado.cnpjCpfFornecedor),
              Container(
                color: CupertinoColors.systemGrey6,
                child: DeputadoInfoWithCopy(
                  infoName: 'Valor Liquido',
                  infoValue: deputadoDespesasDado.valorLiquido.toString(),
                ),
              ),
              DeputadoInfoWithCopy(
                infoName: 'Data',
                infoValue: getDocumentoData(),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: CupertinoColors.systemRed,
                child: CupertinoButton(
                  child: const Icon(
                    CupertinoIcons.doc,
                    color: CupertinoColors.white,
                    size: 30,
                  ),
                  onPressed: () => launch(deputadoDespesasDado.urlDocumento!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabNotasFiscais extends StatelessWidget {
  const TabNotasFiscais(
      {Key? key, required this.deputadoDado, required this.deputadoDespesas})
      : super(key: key);
  final DeputadoDado deputadoDado;
  final DeputadoDespesas deputadoDespesas;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Expanded(child: DeputadoHeader(deputado: deputadoDado)),
          Divider(
            endIndent: 30,
            indent: 30,
            thickness: 2,
            color: ColorLib.blue.color,
          ),
          Expanded(
            flex: 5,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    for (final DeputadoDespesasDado deputadoDespesasDado
                        in deputadoDespesas.dados)
                      DespesaCard(deputadoDespesasDado: deputadoDespesasDado)
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabGraficos extends StatefulWidget {
  const TabGraficos({Key? key, required this.deputadoDado}) : super(key: key);
  final DeputadoDado deputadoDado;
  @override
  State<TabGraficos> createState() => _TabGraficosState();
}

class _TabGraficosState extends State<TabGraficos> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.1,
          ),
          Expanded(
            child: DeputadoHeader(
              deputado: widget.deputadoDado,
            ),
          ),
          Divider(
            endIndent: 30,
            indent: 30,
            thickness: 2,
            color: ColorLib.blue.color,
          ),
          Expanded(
            flex: 5,
            child: Container(),
          )
        ],
      ),
    );
  }
}
