import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/models/deputado_frentes.dart';
import 'package:vigia_deputados/pages/perfil_deputado/frentes_tab/frente_page/frente_page.dart';
import 'package:vigia_deputados/services/camara_api.dart';
import 'package:vigia_deputados/services/device_info.dart';

class TabFrentes extends StatelessWidget {
  const TabFrentes({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    return FutureBuilder<FrentesResponse>(
      future: CamaraApi().getDeputadoFrentes(deputadoID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<FrentesDado> dados = snapshot.data!.dados;
        return ListView.builder(
          itemCount: dados.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => FrentePage(frenteID: dados[index].id))),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            dados[index].titulo,
                            style: GoogleFonts.dmSans(
                                fontSize: isTablet ? 20 : 15, color: Colors.grey[800]),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
