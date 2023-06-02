import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvancedOptions extends StatefulWidget {
  const AdvancedOptions(
      {Key? key,
      required this.sortByOptions,
      required this.sortBySelectedOption,
      required this.sortOptionCallback,
      required this.searchController,
      required this.searchCallback})
      : super(key: key);
  final List<String> sortByOptions;
  final String sortBySelectedOption;
  final ValueChanged sortOptionCallback;
  final TextEditingController searchController;
  final VoidCallback searchCallback;

  @override
  State<AdvancedOptions> createState() => _AdvancedOptionsState();
}

class _AdvancedOptionsState extends State<AdvancedOptions>
    with SingleTickerProviderStateMixin {
  late bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              CupertinoTextField(
                style: GoogleFonts.montserrat(
                    color: Colors.white, fontWeight: FontWeight.bold),
                cursorColor: Colors.white,
                suffix: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                placeholder: 'Buscar partido',
                placeholderStyle: GoogleFonts.dmSans(color: Colors.white60),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white)),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ordenar por:',
                  style: GoogleFonts.montserrat(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: DropdownButton<String>(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        isExpanded: true,
                        elevation: 12,
                        underline: Container(),
                        value: widget.sortBySelectedOption,
                        items: widget.sortByOptions
                            .map(
                              (e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: widget.sortOptionCallback),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    onHighlightChanged: (value) {
                      setState(() {
                        _isTapped = value;
                      });
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      height: _isTapped ? 30 : 50,
                      width: _isTapped ? 70 : 100,
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Text(
                        'Buscar',
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
