import 'package:flutter/cupertino.dart';

class VDText extends StatelessWidget {
  const VDText(
    this.text, {
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: CupertinoColors.black),
    );
  }
}
