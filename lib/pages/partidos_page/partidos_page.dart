import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/partidos_response.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class PartidosPage extends StatefulWidget {
  const PartidosPage({Key? key}) : super(key: key);

  @override
  State<PartidosPage> createState() => _PartidosPageState();
}

class _PartidosPageState extends State<PartidosPage> {
  final CamaraApi _api = CamaraApi();
  late Future<PartidosResponse> _partidosRequest;
  int _page = 1;

  @override
  void initState() {
    super.initState();

    _partidosRequest = _api.getPartidos(pag: _page);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Partidos',
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold, color: CupertinoColors.systemGrey),
        ),
      ),
      child: FutureBuilder<PartidosResponse>(
        future: _partidosRequest,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          return ListView(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.dados.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return PartidoWidget(dado: snapshot.data!.dados[index]);
                  }),
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    if (_page > 1) ...{
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _page -= 1;
                          }),
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                    } else ...{
                      const Spacer(),
                    },
                    Expanded(
                      child: Center(
                        child: Text(
                          '$_page',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    if (snapshot.data!.dados.isNotEmpty) ...{
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _page += 1;
                          }),
                          child: const Icon(
                            CupertinoIcons.arrow_right,
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                    } else ...{
                      const Spacer()
                    }
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PartidoWidget extends StatelessWidget {
  const PartidoWidget({Key? key, required this.dado}) : super(key: key);
  final Dado dado;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(),
              child: Text(dado.sigla),
            ),
            Text(
              dado.nome,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.systemGrey2),
            )
          ],
        ),
      ),
    );
  }
}
