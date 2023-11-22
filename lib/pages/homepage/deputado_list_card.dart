import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';
import 'package:vigia_deputados/pages/perfil_deputado/perfil_deputado.dart';

class DeputadoListCard extends StatelessWidget {
  const DeputadoListCard(
      {Key? key, required this.deputado, required this.favorite, required this.isFavorite})
      : super(key: key);
  final DeputadoDado deputado;
  final VoidCallback favorite;
  final bool? isFavorite;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PerfilDeputado(deputadoID: deputado.id),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: ColorLib.whiteLilac.color),
            borderRadius: BorderRadius.circular(20)),
        height: 100,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.hardEdge,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    favorite();
                    if (isFavorite != null && !isFavorite!) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PerfilDeputado(deputadoID: deputado.id),
                          ));
                    }
                  },
                  icon: isFavorite != null && isFavorite!
                      ? const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      : const Icon(Icons.star_border)),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.network(deputado.urlFoto),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      deputado.nome,
                      style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text('${deputado.siglaPartido}-${deputado.siglaUf}')
                  ],
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
