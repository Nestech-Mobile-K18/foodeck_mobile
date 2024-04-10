import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class CrossBar extends StatelessWidget {
  final double height;
  final double? width;
  final Color? color;
  const CrossBar({super.key, required this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.maxFinite,
      color: color ?? ColorsGlobal.dividerGrey,
    );
  }
}
