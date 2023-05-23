import 'package:flutter/material.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            const Spacer(),
            const Text('Ordenar por:'),
            const SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ],
        ),
      ),
    );
  }
}
