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
      padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Badge(
                    isLabelVisible: false,
                    largeSize: 20,
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    textStyle: inter.copyWith(fontSize: 12),
                    backgroundColor: Colors.black,
                    label: Text('1'),
                    child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: AssetImage(widget.picture),
                                fit: BoxFit.cover))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: RichText(
                        text: TextSpan(
                            text: widget.nameFood,
                            style: inter.copyWith(
                                fontSize: 17, color: Colors.black),
                            children: [
                          TextSpan(
                              text: widget.detail,
                              style: inter.copyWith(
                                  fontSize: 15, color: Colors.grey)),
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.highlight_remove,
                    color: Colors.grey,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Divider(
              color: Colors.grey[300],
            ),
          )
        ],
      ),
    );
  }
}
