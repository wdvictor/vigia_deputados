// cSpell: ignore Camara camara

import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CamaraApi _camaraApi;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _camaraApi = CamaraApi();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    final double _axisSpacing = _size.width * 0.02;
    return Scaffold(
      body: FutureBuilder<DeputadosResponse>(
        future: _camaraApi.getDeputados(),
        builder:
            (BuildContext context, AsyncSnapshot<DeputadosResponse> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: _axisSpacing,
            mainAxisSpacing: _axisSpacing,
            children: [
              for (final Dado dado in snapshot.data!.dados)
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: _size.height * 0.2,
                          child: Image.network(dado.urlFoto)),
                      Text(dado.nome),
                      Text(dado.siglaPartido),
                    ],
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
