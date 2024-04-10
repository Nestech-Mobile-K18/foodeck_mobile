import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class ErrorDialog {
  void showError(BuildContext context, String title, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: color ?? ColorsGlobal.globalPink,
    ));
  }
}
