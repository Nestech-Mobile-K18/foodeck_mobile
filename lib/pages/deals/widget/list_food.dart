import 'package:flutter/material.dart';
import 'package:template/values/text_styles.dart';

class ListFood extends StatefulWidget {
  const ListFood(
      {super.key,
      required this.picture,
      required this.nameFood,
      required this.detail,
      required this.price});

  final String picture;
  final String nameFood;
  final String detail;
  final String price;

  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Row(
        children: [
          Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(widget.picture), fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: RichText(
                text: TextSpan(
                    text: widget.nameFood,
                    style: inter.copyWith(fontSize: 17, color: Colors.black),
                    children: [
                  TextSpan(
                      text: widget.detail,
                      style: inter.copyWith(fontSize: 15, color: Colors.grey)),
                  WidgetSpan(
                      child: SizedBox(
                    height: 30,
                  )),
                  TextSpan(
                      text: widget.price,
                      style: inter.copyWith(
                          fontSize: 15, fontWeight: FontWeight.bold))
                ])),
          )
        ],
      ),
    );
  }
}
