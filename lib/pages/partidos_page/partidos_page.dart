import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show Material, Colors, DropdownButton, DropdownMenuItem;
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
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
  String _sortBy = 'sigla';
  final List<String> _sortOptions = ['sigla', 'nome'];

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
        future: _api.getPartidos(pag: _page, sortBy: _sortBy),
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
              SortByWidget(
                  sortByOptions: _sortOptions,
                  sortBySelectedOption: _sortBy,
                  callback: (value) {
                    setState(() {
                      _sortBy = value;
                    });
                  }),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.dados.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
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
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                    } else ...{
                      const Spacer(),
                    },
                    Expanded(
                      child: Center(
                        child: Material(
                          child: Text(
                            '$_page',
                            style: GoogleFonts.montserrat(
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

class PartidoWidget extends StatefulWidget {
  const PartidoWidget(
      {Key? key,
      required this.dado,
      required this.animationMillisecondsDuration})
      : super(key: key);
  final Dado dado;
  final int animationMillisecondsDuration;
  @override
  State<PartidoWidget> createState() => _PartidoWidgetState();
}

class _PartidoWidgetState extends State<PartidoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationMillisecondsDuration),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorLib.darkBlue.color,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(),
                          child: Text(
                            widget.dado.sigla,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: CupertinoColors.white),
                          ),
                        ),
                        Text(
                          widget.dado.nome,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class SortByWidget extends StatelessWidget {
  const SortByWidget(
      {Key? key,
      required this.sortByOptions,
      required this.sortBySelectedOption,
      required this.callback})
      : super(key: key);
  final List<String> sortByOptions;
  final String sortBySelectedOption;
  final ValueChanged callback;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          margin: EdgeInsets.only(left: size.width * 0.7),
          constraints: BoxConstraints.tight(const Size(150, 50)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorLib.darkBlue.color)),
          child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(20),
              isExpanded: true,
              elevation: 12,
              underline: Container(),
              value: sortBySelectedOption,
              items: sortByOptions
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: callback),
        ),
      ),
    );
  }
}
