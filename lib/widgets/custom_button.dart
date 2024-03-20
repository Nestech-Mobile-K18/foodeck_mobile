import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final double? border;
  final String title;
  final double? titleSize;
  final Color? colorTitle;
  const CustomButton(
      {super.key,
      required this.color,
      this.border,
      required this.colorTitle,
      this.titleSize,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      alignment: Alignment.center,
      height: 65,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: border ?? 0, color: ColorsGlobal.globalGrey),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: titleSize ?? 17,
            fontWeight: FontWeight.w700,
            color: colorTitle ?? Colors.white),
      ),
    );
  }
}
