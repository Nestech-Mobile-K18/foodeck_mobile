import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
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
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Bạn đã thích sản phẩm này',
              style: inter,
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: globalPinkShadow,
          )));
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
      }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Bạn đã xóa thích sản phẩm này',
              style: inter,
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: buttonShadowBlack,
          )));
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      child: BannerItems(
                          foodImage: bottomList[index].bottomFood,
                          deliveryTime: bottomList[index].timeSend,
                          shopName: bottomList[index].popular,
                          shopAddress: bottomList[index].zone,
                          rateStar: bottomList[index].star,
                          action: () {
                            check(index);
                          },
                          heartColor: like[index])))))
    ]);
  }
}
