import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

import '../../../main.dart';

class BottomListShopping extends StatefulWidget {
  const BottomListShopping({
    super.key,
  });

  @override
  State<BottomListShopping> createState() => _BottomListShoppingState();
}

class _BottomListShoppingState extends State<BottomListShopping> {
  List<bool> like = [false, false, false];
  void check(int index) {
    setState(() {
      switch (index) {
        case 0:
          like[0] = !like[0];
          like[0] ? saveBanner(index) : deleteBanner(index);
          break;
        case 1:
          like[1] = !like[1];
          like[1] ? saveBanner(index) : deleteBanner(index);
          break;
        case 2:
          like[2] = !like[2];
          like[2] ? saveBanner(index) : deleteBanner(index);
          break;
      }
    });
  }

  Future saveBanner(index) async {
    try {
      await supabase.from('banners').upsert({
        'food': bottomList[index].bottomFood,
        'time': bottomList[index].timeSend,
        'shop_name': bottomList[index].popular,
        'place': bottomList[index].zone,
        'vote': bottomList[index].star
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  Future deleteBanner(index) async {
    try {
      await supabase.from('banners').delete().match({
        'food': bottomList[index].bottomFood,
        'time': bottomList[index].timeSend,
        'shop_name': bottomList[index].popular,
        'place': bottomList[index].zone,
        'vote': bottomList[index].star
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error occurred, please retry')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore More',
          style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 674,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bottomList.length,
                scrollDirection: Axis.vertical,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(alignment: Alignment.topRight, children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.red,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        bottomList[index].bottomFood,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                              ),
                            ),
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    bottomList[index].timeSend,
                                    style: inter.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  check(index);
                                },
                                icon: Icon(
                                  like[index]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color:
                                      like[index] ? globalPink : Colors.white,
                                ))
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: bottomList[index].popular,
                                      style: inter.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: [
                                    TextSpan(
                                        text: bottomList[index].zone,
                                        style: inter.copyWith(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal))
                                  ])),
                              TextButton.icon(
                                style: const ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.zero)),
                                onPressed: null,
                                label: Text(bottomList[index].star,
                                    style: inter.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                icon: const Icon(
                                  Icons.star,
                                  color: voteYellow,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
          ),
        )
      ],
    );
  }
}
