import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void errorDialog(
    {required BuildContext context, required Object? error, bool navigatePop = false}) {
  if (error is HttpException) {
    dialog(context: context, error: error.message, navigatePop: navigatePop).show();
  } else if (error is TimeoutException) {
    dialog(context: context, error: error.message.toString(), navigatePop: navigatePop).show();
  } else {
    dialog(context: context, error: 'Um erro desconhecido aconteceu!', navigatePop: navigatePop)
        .show();
  }
}

AwesomeDialog dialog({
  required BuildContext context,
  required String error,
  required bool navigatePop,
}) =>
    AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      animType: AnimType.topSlide,
      dialogType: DialogType.error,
      desc: error,
      descTextStyle: GoogleFonts.dmSans(fontSize: 16),
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.redAccent,
      btnOkOnPress: () {
        if (navigatePop) Navigator.pop(context);
      },
    );
