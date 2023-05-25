import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material, Colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/partidos_response.dart';
import 'package:vigia_deputados/pages/partidos_page/partido_grid_widget.dart';
import 'package:vigia_deputados/pages/partidos_page/sort_dropdown_widget.dart';
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
  String _sortBy = 'sigla';
  final List<String> _sortOptions = ['sigla', 'nome'];
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _partidosRequest = _api.getPartidos(pag: _page, sortBy: _sortBy);
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
              child: CupertinoActivityIndicator(
                color: Colors.black,
                radius: 30,
              ),
            );
          }

          return ListView(
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            children: [
              AdvancedOptions(
                  sortByOptions: _sortOptions,
                  sortBySelectedOption: _sortBy,
                  searchController: _searchController,
                  searchCallback: () {},
                  sortOptionCallback: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.dados.length,
                  itemBuilder: (context, index) {
                    return PartidoWidget(
                      dado: snapshot.data!.dados[index],
                      animationMillisecondsDuration: 100 * index,
                    );
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
                            color: CupertinoColors.white,
                          ),
                        ),
                      ),
                    } else ...{
                      const Spacer(),
                    },
                    Expanded(
                      child: Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            '$_page',
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
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
                            color: CupertinoColors.white,
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