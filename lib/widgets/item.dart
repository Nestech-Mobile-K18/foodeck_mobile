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
            padding: EdgeInsets.all(12.dp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.dp),
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
                        height: 24.dp,
                        width: 24.dp,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: IconButton(
                              icon: Icon(
                                isLike ? Icons.favorite : Icons.favorite_border,
                                color: isLike
                                    ? Colors.pink
                                    : Colors.white.withOpacity(0.6),
                              ),
                              onPressed: () {},
                            )))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 57.dp,
                      height: 24.dp,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.dp),
                        ),
                        child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(8.dp, 4.dp, 8.dp, 4.dp),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                isTypeTime
                                    ? '${value} ${unit}'
                                    : '${unit}${value}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.dp,
                                    fontWeight: FontWeight.w900),
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
          height: 8.dp,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 17.dp,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
            Spacer(),
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
                      color: Colors.black,
                      fontSize: 13.dp,
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
              color: Colors.grey, fontSize: 15.dp, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 16.dp,
        )
      ],
    );
  }
}
