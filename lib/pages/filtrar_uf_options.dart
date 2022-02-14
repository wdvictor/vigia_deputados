//cSpell:ignore cupertino
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltrarUfsPage extends StatefulWidget {
  const FiltrarUfsPage(
      {Key? key, required this.ufsSelecionadas, this.alreadySelectedUfs})
      : super(key: key);
  final ValueChanged<List<String>> ufsSelecionadas;
  final List<String>? alreadySelectedUfs;
  @override
  State<FiltrarUfsPage> createState() => _FiltrarUfsPageState();
}

class _FiltrarUfsPageState extends State<FiltrarUfsPage> {
  late List<bool> selectedUfs;

  List<String> allUFs = [
    'BA',
    'SP',
    'AP',
    'GO',
    'MG',
    'RS',
    'PB',
    'PA',
    'CE',
    'AC',
    'RJ',
    'PR',
    'MA',
    'ES',
    'PE',
    'SC',
    'AL',
    'PI',
    'AM',
    'RN',
    'MS',
    'DF',
    'SE',
    'MT',
    'TO',
    'RO',
    'RR'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.alreadySelectedUfs == null) {
      selectedUfs = [for (int i = 0; i < allUFs.length; i++) false];
    } else {
      for (final String uf in widget.alreadySelectedUfs!) {
        int index = allUFs.indexWhere((element) => element == uf);
        selectedUfs[index] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Selecionar UF\'s'),
      ),
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            flex: 4,
            child: CustomScrollView(
              slivers: [
                SliverGrid.count(
                  crossAxisCount: 5,
                  children: <Widget>[
                    for (int i = 0; i < allUFs.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(1),
                        child: Material(
                          elevation: 0,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: selectedUfs[i],
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedUfs[i] = value!;
                                    },
                                  );
                                },
                              ),
                              Text(allUFs[i])
                            ],
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: CupertinoButton(
                color: selectedUfs.contains(true)
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.systemGrey,
                onPressed: () {},
                child: const Text('Selecionar'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
