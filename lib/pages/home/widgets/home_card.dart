import 'package:flutter/material.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../resources/const.dart';

class HomeCard extends StatelessWidget {
  final String? imgString;
  final String? headerText;
  final String? contentText;
  final double? heightCard;
  final double? widthCard;

  const HomeCard(
      {super.key,
      required this.imgString,
      required this.headerText,
      required this.contentText,
      this.widthCard,
      this.heightCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: heightCard ?? 160,
      width: widthCard ?? double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgString ?? ''),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              title: headerText ?? '',
              size: 20,
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
              color: ColorsGlobal.globalWhite,
            ),
            CustomText(
              title: contentText ?? '',
              size: 16,
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
              color: ColorsGlobal.globalWhite,
            ),
          ],
        ),
      ),
    );
  }
}
