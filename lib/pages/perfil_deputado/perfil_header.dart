import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
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

    String getImageName(String rede) {
      final Map<String, String> redesSociais = {
        'twitter': 'assets/images/twitter_logo.png',
        'instagram': 'assets/images/instagram_logo.png',
        'facebook': 'assets/images/facebook_logo.png',
        'youtube': 'assets/images/youtube_logo.png',
        'site': 'assets/images/site.png'
      };
      if (rede.contains('twitter')) {
        return redesSociais['twitter']!;
      }

      if (rede.contains('youtube')) {
        return redesSociais['youtube']!;
      }

      if (rede.contains('facebook')) {
        return redesSociais['facebook']!;
      }

      if (rede.contains('instagram')) {
        return redesSociais['instagram']!;
      }

      return redesSociais['site']!;
    }

    return Container(
      height: size.height * 0.2,
      width: size.width,
      decoration: BoxDecoration(
        color: ColorLib.primaryColor.color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < deputado.redeSocial.length; i++) ...{
                    GestureDetector(
                      onTap: () => {launchUrl(Uri.parse(deputado.redeSocial[i]))},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: isTablet ? 40 : 25,
                        height: isTablet ? 40 : 25,
                        child: Image.asset(
                          getImageName(
                            deputado.redeSocial[i],
                          ),
                          color: Colors.white,
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
