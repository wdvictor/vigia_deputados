import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, IconButton, Material, Icons;
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/backend/api/api_partidodos.dart';
import 'package:vigia_deputados/backend/domain/domain_partidos.dart';
import 'package:vigia_deputados/models/partidos_response.dart';
import 'package:vigia_deputados/pages/partidos_page/partido_grid_widget.dart';
import 'package:vigia_deputados/pages/partidos_page/sort_dropdown_widget.dart';

class PartidosPage extends StatefulWidget {
  const PartidosPage({Key? key}) : super(key: key);

  @override
  State<PartidosPage> createState() => _PartidosPageState();
}

class _PartidosPageState extends State<PartidosPage> {
  final PartidoDomain _partidoDomain = PartidoDomain(APIpartidos());
  late Future<PartidosResponse> _partidosRequest;
  int _page = 1;
  String _sortBy = 'sigla';
  final List<String> _sortOptions = ['sigla', 'nome'];
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _partidosRequest =
        _partidoDomain.getPartidos(pagina: _page, sortBy: _sortBy);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/CAMARA_01.jpg'))),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ),
                  ),
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
        ),
      ],
    );
  }
}
