//cSpell:ignore cupertino camara endereco predio andarº municipio
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/deputado_despesas.dart';
import 'package:vigia_deputados/services/camara_api.dart';
import 'package:vigia_deputados/widgets/deputado_header.dart';
import 'package:vigia_deputados/widgets/deputado_info_with_copy.dart';

class DeputadoProfilePage extends StatefulWidget {
  const DeputadoProfilePage({Key? key, required this.deputado})
      : super(key: key);
  final DeputadoDado deputado;

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

  String getEnderecoGabinete(DeputadoDetalhadoResponse deputado) {
    String? sala = deputado.dados.ultimoStatus.gabinete.sala;
    String? andar = deputado.dados.ultimoStatus.gabinete.andar;
    String? predio = deputado.dados.ultimoStatus.gabinete.predio;
    if (sala == null || andar == null || predio == null) return '';
    return 'Prédio $predio, $andarº Andar, Sala $sala';
  }

  String getDataNascimentoFormatado(DeputadoDetalhadoResponse deputado) {
    int dia = deputado.dados.dataNascimento.day;
    int mes = deputado.dados.dataNascimento.month;
    int ano = deputado.dados.dataNascimento.year;
    return '$dia/$mes/$ano';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            widget.deputado.nome,
            style: const TextStyle(color: CupertinoColors.systemBlue),
          ),
          backgroundColor: Colors.transparent,
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Expanded(
              child: DeputadoHeader(
                deputado: widget.deputado,
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
              child: FutureBuilder<DeputadoDetalhadoResponse>(
                future: _camaraApi.getDeputadoInfo(widget.deputado.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  DeputadoDetalhadoResponse deputadoInfo = snapshot.data!;
                  return CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: Text(
                                  'Mais Informações',
                                  style: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Nome Completo',
                              infoValue: deputadoInfo.dados.nomeCivil,
                              showCopyWidget: true,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Email',
                              infoValue: deputadoInfo.dados.ultimoStatus.email,
                              showCopyWidget: true,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Telefone\n(Gabinete)',
                              infoValue: deputadoInfo.dados.ultimoStatus
                                          .gabinete.telefone ==
                                      null
                                  ? ''
                                  : deputadoInfo
                                      .dados.ultimoStatus.gabinete.telefone!,
                              showCopyWidget: true,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Endereço Gabinete',
                              infoValue: getEnderecoGabinete(deputadoInfo),
                              showCopyWidget: true,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Sexo',
                              infoValue: deputadoInfo.dados.sexo == 'M'
                                  ? 'Masculino'
                                  : 'Feminino',
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Data de Nascimento',
                              infoValue:
                                  getDataNascimentoFormatado(deputadoInfo),
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Município de Nascimento',
                              infoValue: deputadoInfo.dados.municipioNascimento,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'UF de Nascimento',
                              infoValue: deputadoInfo.dados.ufNascimento,
                            ),
                            DeputadoInfoWithCopy(
                              infoName: 'Escolaridade',
                              infoValue: deputadoInfo.dados.escolaridade,
                            ),
                          ],
                        ),
                      ),
                      SliverGrid.count(
                        // crossAxisSpacing: 25,
                        // mainAxisSpacing: 25,
                        crossAxisCount: 2,
                        children: <Widget>[
                          GridViewButton(
                            title: 'Despesas',
                            icon: CupertinoIcons.graph_square,
                            navigationFunction: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => DeputadoDespesasPage(
                                  deputadoDado: widget.deputado,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridViewButton extends StatelessWidget {
  const GridViewButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.navigationFunction,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final Function() navigationFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Material(
        elevation: 10,
        color: CupertinoColors.tertiarySystemGroupedBackground,
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
          onTap: navigationFunction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 60,
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
