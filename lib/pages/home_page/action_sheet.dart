import 'package:flutter/cupertino.dart';
import 'package:vigia_deputados/pages/home_page/filtrar_uf_options.dart';
import 'package:vigia_deputados/widgets/vd_text.dart';

class MenuActionSheet extends StatelessWidget {
  const MenuActionSheet(
      {Key? key, required this.ufsSelecionadas, this.alreadySelectedUfs})
      : super(key: key);
  final ValueChanged<List<String>> ufsSelecionadas;
  final List<String>? alreadySelectedUfs;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      cancelButton: CupertinoButton(
        color: CupertinoColors.systemRed,
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancelar'),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          onPressed: () {},
          child: const VDText(
            'Filtrar por nome',
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () {},
          child: const VDText('Filtrar por partido'),
        ),
        // CupertinoActionSheetAction(
        //   onPressed: () => Navigator.push(
        //     context,
        //     CupertinoPageRoute(
        //       builder: (context) => FiltrarUfsPage(
        //         ufsSelecionadas: ufsSelecionadas,
        //         alreadySelectedUfs: alreadySelectedUfs,
        //       ),
        //     ),
        //   ).then(
        //     (value) => Navigator.pop(context),
        //   ),
        //   child: const VDText('Filtrar por UF'),
        // ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {},
          child: const Text('Limpar Filtros'),
        ),
      ],
    );
  }
}
