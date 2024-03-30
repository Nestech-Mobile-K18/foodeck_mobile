import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/research_bar.dart';

class Homebar extends StatelessWidget {
  final String? address;
  const Homebar({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(MediaRes.homebar),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                MediaRes.location,
                width: 25,
                height: 25,
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                child: CustomText(
                  title: address ?? '',
                  maxLine: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  color: ColorsGlobal.globalWhite,
                  size: 18,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ReSearchBar(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
