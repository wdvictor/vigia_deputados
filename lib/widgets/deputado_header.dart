import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class DeputadoHeader extends StatelessWidget {
  const DeputadoHeader({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDado deputado;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: 'DEP-${deputado.id}',
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Material(
                shape: const CircleBorder(),
                elevation: 12,
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(deputado.urlFoto, scale: 10),
                      radius: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nome:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Partido:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'UF:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deputado.nome,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          deputado.siglaPartido,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          deputado.siglaUf,
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
