import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Item extends StatelessWidget {
  const Item(
      {Key? key,
      required this.isLike,
      required this.rate,
      required this.img,
      required this.isMoney,
      this.right,
      this.left,
      this.bottom,
      this.top,
      required this.height,
      required this.width,
      required this.title,
      required this.value,
      required this.unit,
      required this.shopName})
      : super(key: key);
  final String title;
  final bool isLike;
  final double rate;
  final String value;
  final String unit;
  final String shopName;
  final String img;
  final bool isMoney;
  final double? right;
  final double? left;
  final double? bottom;
  final double? top;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.fromLTRB(left ?? 0, top ?? 0, right ?? 0, bottom ?? 0),
      // padding: EdgeInsets.fromLTRB(left??0, top??0, right??0, bottom??0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.dp),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.dp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 240.dp,
              height: 57.dp,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16.dp),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.dp,
                    vertical: 8.dp,
                  ),
                  child:Text(value)
                ),
              ),
            ),
            Text(
              title,
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.dp,
                  fontWeight: FontWeight.w400),
            ),
            // Text(decription ?? '',
            //     softWrap: true,
            //     style: TextStyle(color: Colors.white, fontSize: 16.dp))
          ],
        ),
      ),
    );
  }
}
