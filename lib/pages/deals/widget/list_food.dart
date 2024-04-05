import 'package:flutter/material.dart';
import 'package:template/values/text_styles.dart';

class ListFood extends StatefulWidget {
  const ListFood(
      {super.key,
      required this.picture,
      required this.nameFood,
      required this.detail,
      required this.price,
      required this.voidCallback});

  final String picture;
  final String nameFood;
  final String detail;
  final String price;
  final VoidCallback voidCallback;

  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.voidCallback,
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: RichText(
                    text: TextSpan(
                        text: widget.nameFood,
                        style:
                            inter.copyWith(fontSize: 17, color: Colors.black),
                        children: [
                      TextSpan(
                          text: widget.detail,
                          style:
                              inter.copyWith(fontSize: 15, color: Colors.grey)),
                      WidgetSpan(
                          child: SizedBox(
                        height: 30,
                      )),
                      TextSpan(
                          text: widget.price,
                          style: inter.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold))
                    ])),
                leading: Badge(
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
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.highlight_remove, color: Colors.grey))),
          ),
          Divider(color: Colors.grey[300])
        ],
      ),
    );
  }
}
