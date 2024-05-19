import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:template/pages/export.dart';

class Item extends StatelessWidget {
  const Item(
      {Key? key,
      required this.isLike,
      required this.rate,
      required this.img,
      required this.isMoney,
      required this.height,
      required this.title,
      required this.value,
      required this.unit,
      required this.address,
      required this.isTypeTime,
      required this.id})
      : super(key: key);
  final String id;
  final String title;
  final bool isLike;
  final double rate;
  final String value;
  final String unit;
  final String address;
  final String img;
  final bool isMoney;
  final double height;
  final bool isTypeTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Container(
            height: height,
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.p24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r16),
              image: DecorationImage(
                image: AssetImage(img),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: AppSize.s24,
                        width: AppSize.s24,
                        decoration: BoxDecoration(
                          color: ColorsGlobal.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(
                              icon: Icon(
                                isLike ? Icons.favorite : Icons.favorite_border,
                                color: isLike
                                    ? ColorsGlobal.globalPink
                                    : ColorsGlobal.white.withOpacity(0.6),
                              ),
                              onPressed: () {},
                            )))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: AppSize.s57,
                      height: AppSize.s24,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorsGlobal.white,
                          borderRadius: BorderRadius.circular(AppRadius.r16),
                        ),
                        child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p4),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                isTypeTime
                                    ? '$value $unit'
                                    : '$unit$value',
                                style: AppTextStyle.priceSmallBold,
                              ),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: AppSize.s17,
                  color: ColorsGlobal.black,
                  fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star_outlined,
                      color: Colors.yellow.shade800,
                    )),
                Text(
                  rate.toString(),
                  style: TextStyle(
                      color: ColorsGlobal.black,
                      fontSize: AppSize.s13,
                      fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        Text(
          address,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: ColorsGlobal.grey, fontSize: AppSize.s15, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: AppSize.s16,
        )
      ],
    );
  }
}
