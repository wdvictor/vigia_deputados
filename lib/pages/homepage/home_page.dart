import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/all_deputados_notifier.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildBody(List<DeputadoDado> deputados) {
    final List<Widget> widgets = [];
    const titleWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deputados em exercício',
            style: TextStyle(color: Colors.grey, fontFamily: 'inter-bold', fontSize: 18),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
    widgets.add(titleWidget);
    for (final deputado in deputados) {
      widgets.add(DeputadoWidget(deputado: deputado));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorLib.primaryColor.color,
        ),
        body: Consumer<AllDeputadosNotifier>(
          builder: (context, allDeputados, _) {
            if (allDeputados.allDeputadosResponse == null) {
              allDeputados.getDeputados();
              return const CupertinoActivityIndicator();
            }

            List<Widget> bodyWidget = _buildBody(allDeputados.allDeputadosResponse!.dados);
            return ListView.builder(
                itemCount: bodyWidget.length,
                itemBuilder: (context, index) {
                  return bodyWidget[index];
                });
          },
        ));
  }
}

class DeputadoWidget extends StatelessWidget {
  const DeputadoWidget({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDado deputado;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 100,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.hardEdge,
        color: ColorLib.whiteLilac.color,
        elevation: 12,
        child: Row(
          children: [
            Image.network(deputado.urlFoto),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deputado.nome,
                    style: const TextStyle(fontFamily: 'inter-medium', color: Colors.grey),
                  ),
                  Text(
                    deputado.siglaPartido,
                    style: const TextStyle(fontFamily: 'inter-bold', color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
                child: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
              onPressed: () => {},
            ))
          ],
        ),
      ),
    );
  }
}
