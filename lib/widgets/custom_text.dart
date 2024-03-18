import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final int? maxLine;
  final FontWeight? fontWeight;
  const CustomText(
      {super.key,
      required this.title,
      this.size = 13,
      this.maxLine,
      this.color,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLine ?? 1,
      style: TextStyle(
          fontSize: size,
          color: color ?? ColorsGlobal.globalGrey,
          fontWeight: fontWeight ?? FontWeight.w400),
    );
  }
}
