import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/deputado_detalhado_response_model.dart';
import 'package:vigia_deputados/services/device_info.dart';

class PerfilHeader extends StatelessWidget {
  const PerfilHeader({Key? key, required this.deputado}) : super(key: key);
  final DeputadoDetalhadoDado deputado;
  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
        color: ColorLib.primaryColor.color,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CircleAvatar(
                    radius: isTablet ? 100 : 50,
                    backgroundImage: NetworkImage(deputado.ultimoStatus.urlFoto),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      Text(
                        deputado.nomeCivil,
                        style: GoogleFonts.dmSans(
                            fontSize: isTablet ? 23 : 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${deputado.ultimoStatus.siglaPartido}-${deputado.ultimoStatus.siglaUf}',
                        style: GoogleFonts.dmSans(
                            fontSize: isTablet ? 22 : 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
