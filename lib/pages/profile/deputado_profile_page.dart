//cSpell:ignore cupertino camara
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class DeputadoProfilePage extends StatefulWidget {
  const DeputadoProfilePage({Key? key, required this.deputado})
      : super(key: key);
  final Dado deputado;

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
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  'Mais Informações',
                  style: TextStyle(
                      color: CupertinoColors.systemGrey, fontSize: 20),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                              DeputadoInfoWithCopy(
                                  infoName: 'Email',
                                  infoValue:
                                      deputadoInfo.dados.ultimoStatus.email),
                              DeputadoInfoWithCopy(
                                  infoName: 'Telefone\n(Gabinete)',
                                  infoValue: deputadoInfo
                                      .dados.ultimoStatus.gabinete.telefone),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeputadoInfoWithoutCopy extends StatelessWidget {
  const DeputadoInfoWithoutCopy(
      {Key? key, required this.infoName, required this.infoValue})
      : super(key: key);
  final String infoName;
  final String infoValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$infoName:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black.withOpacity(0.6),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text.rich(
            TextSpan(
              text: '  $infoValue',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: CupertinoColors.systemGrey2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DeputadoHeader extends StatelessWidget {
  const DeputadoHeader({Key? key, required this.deputado}) : super(key: key);
  final Dado deputado;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'DEP-${deputado.id}',
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Material(
                shape: const CircleBorder(),
                elevation: 12,
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ColorLib.green.color, width: 4)),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ColorLib.blue.color, width: 2.5),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(deputado.urlFoto, scale: 10),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Partido:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'UF:',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                          deputado.nome,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          deputado.siglaPartido,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          deputado.siglaUf,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class DeputadoInfoWithCopy extends StatefulWidget {
  const DeputadoInfoWithCopy(
      {Key? key, required this.infoName, required this.infoValue})
      : super(key: key);
  final String infoName;
  final String infoValue;

  @override
  State<DeputadoInfoWithCopy> createState() => _DeputadoInfoWithCopyState();
}

class _DeputadoInfoWithCopyState extends State<DeputadoInfoWithCopy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 10,
          child: DeputadoInfoWithoutCopy(
              infoName: widget.infoName, infoValue: widget.infoValue),
        ),
        CupertinoButton(
          child: const Icon(
            CupertinoIcons.doc_on_clipboard,
            color: CupertinoColors.systemGrey,
          ),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: widget.infoValue),
            );
          },
        )
      ],
    );
  }
}
