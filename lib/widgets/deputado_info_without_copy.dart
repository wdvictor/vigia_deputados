import 'package:flutter/cupertino.dart';

class DeputadoInfoWithoutCopy extends StatelessWidget {
  const DeputadoInfoWithoutCopy(
      {Key? key, required this.infoName, required this.infoValue})
      : super(key: key);
  final String infoName;
  final String infoValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$infoName:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black.withOpacity(0.6),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text.rich(
              TextSpan(
                text: '  $infoValue',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.normal,
                  color: CupertinoColors.systemGrey2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
