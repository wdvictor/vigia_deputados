import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';
import 'package:vigia_deputados/pages/homepage/deputado_list_card.dart';
import 'package:vigia_deputados/pages/homepage/deputados_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  List<DeputadoDado> todosDeputados = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vigia Deputados'),
          actions: [
            IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: DeputadoSearchDelegete(todosDeputados)),
                icon: Icon(Icons.search))
          ],
        ),
        body: Consumer<DeputadoNotifier>(
          builder: (context, deputados, _) {
            if (deputados.deputados == null) {
              deputados.fetchDeputados();

              return const CupertinoActivityIndicator();
            }

            /// Criar errorDialog para descobrir quais tipos de exceptions
            /// essa função vai retornar
            if (deputados.fetchDeputadosException != null) {
              AlertDialog(
                content: Text(deputados.fetchDeputadosException.toString()),
              );
            }

            todosDeputados = deputados.deputados!.dados;

            return ListView.builder(
              itemCount: todosDeputados.length,
              itemBuilder: (context, index) => DeputadoListCard(deputado: todosDeputados[index]),
            );
          },
        ));
  }
}
