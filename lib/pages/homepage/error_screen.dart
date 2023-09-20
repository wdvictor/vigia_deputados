import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    final deputados = Provider.of<DeputadoNotifier>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/urban-error-404.png'),
          InkWell(
            onTap: () {
              deputados.setError(null);
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: ColorLib.primaryColor.color, width: 3)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text('Tentar de novo'),
                  Spacer(),
                  Icon(Icons.refresh),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
