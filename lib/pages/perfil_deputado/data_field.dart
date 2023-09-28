import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/services/device_info.dart';

class DataField extends StatelessWidget {
  const DataField({Key? key, required this.title, required this.data, this.showCopyButton = false})
      : super(key: key);
  final String title;
  final String data;
  final bool showCopyButton;

  void _copyToClipboard(BuildContext context, String textToCopy) {
    Clipboard.setData(ClipboardData(text: textToCopy));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            const Icon(
              Icons.done_outlined,
              color: Colors.white,
            ),
            Text(
              'Texto copiado!',
              style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: ColorLib.dataFieldColor.color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15, color: Colors.grey[700]),
                ),
                Text(
                  data,
                  style:
                      GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          if (showCopyButton)
            GestureDetector(
              onTap: () => _copyToClipboard(context, data),
              child: const Icon(Icons.copy),
            )
        ],
      ),
    );
  }
}
