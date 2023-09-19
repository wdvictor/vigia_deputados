import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/models/notifiers/deputados_notifier.dart';
import 'package:vigia_deputados/pages/homepage/deputado_list_card.dart';
import 'package:vigia_deputados/pages/homepage/deputados_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<DeputadoDado> todosDeputados = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorLib.primaryColor.color,
          title: const Text('Vigia Deputados'),
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: DeputadoSearchDelegete(todosDeputados)),
              icon: const Icon(Icons.search),
            ),
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

            return Container(
              color: ColorLib.primaryColor.color,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: todosDeputados.length,
                        itemBuilder: (context, index) =>
                            DeputadoListCard(deputado: todosDeputados[index]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
