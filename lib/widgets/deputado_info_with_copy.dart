import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'deputado_info_without_copy.dart';

class DeputadoInfoWithCopy extends StatefulWidget {
  const DeputadoInfoWithCopy(
      {Key? key,
      required this.infoName,
      required this.infoValue,
      this.showCopyWidget = false})
      : super(key: key);
  final String infoName;
  final String infoValue;
  final bool showCopyWidget;

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
        if (widget.showCopyWidget)
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
          ),
        if (!widget.showCopyWidget)
          CupertinoButton(
            child: Container(),
            onPressed: () {},
          )
      ],
    );
  }
}
