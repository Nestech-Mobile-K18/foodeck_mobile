import 'package:flutter/material.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class TopListShopping extends StatelessWidget {
  const TopListShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Stack(children: [
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(food), fit: BoxFit.cover)),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: RichText(
                text: TextSpan(
                    text: 'Food\n',
                    style: inter.copyWith(fontSize: 17, color: Colors.white),
                    children: [
                  TextSpan(
                      text: 'Order food you love',
                      style: inter.copyWith(fontSize: 12))
                ])),
          )
        ]),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Stack(children: [
                Container(
                  height: 160,
                  width: 156,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(grocery), fit: BoxFit.cover)),
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: RichText(
                      text: TextSpan(
                          text: 'Grocery\n',
                          style:
                              inter.copyWith(fontSize: 17, color: Colors.white),
                          children: [
                        TextSpan(
                            text: 'Shop daily life items',
                            style: inter.copyWith(fontSize: 12))
                      ])),
                )
              ]),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Stack(children: [
                Container(
                  height: 160,
                  width: 156,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(desert), fit: BoxFit.cover)),
                ),
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: RichText(
                      text: TextSpan(
                          text: 'Deserts\n',
                          style:
                              inter.copyWith(fontSize: 17, color: Colors.white),
                          children: [
                        TextSpan(
                            text: 'Something Sweet',
                            style: inter.copyWith(fontSize: 12))
                      ])),
                )
              ]),
            )
          ],
        ),
      )
    ]);
  }
}
