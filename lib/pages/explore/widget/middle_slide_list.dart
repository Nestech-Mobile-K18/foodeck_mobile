import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/deals/deals_page.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

import '../../../main.dart';

class MiddleSlideList extends StatefulWidget {
  const MiddleSlideList({
    super.key,
  });

  @override
  State<MiddleSlideList> createState() => _MiddleSlideListState();
}

class _MiddleSlideListState extends State<MiddleSlideList> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);
  final currentCard = ValueNotifier(0);
  List<bool> like = [false, false, false, false, false];
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
        case 3:
          like[3] = !like[3];
          like[3] ? saveBanner(index) : deleteBanner(index);
          break;
        case 4:
          like[4] = !like[4];
          like[4] ? saveBanner(index) : deleteBanner(index);
          break;
      }
    });
  }

  Future saveBanner(index) async {
    try {
      await supabase.from('banners').upsert({
        'food': middleList[index].foodOrder,
        'time': middleList[index].time,
        'shop_name': middleList[index].shopName,
        'place': middleList[index].place,
        'vote': middleList[index].vote
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
        'food': middleList[index].foodOrder,
        'time': middleList[index].time,
        'shop_name': middleList[index].shopName,
        'place': middleList[index].place,
        'vote': middleList[index].vote
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
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Deals',
              style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            ValueListenableBuilder(
              valueListenable: currentCard,
              builder: (BuildContext context, int value, Widget? child) {
                return IconButton(
                    onPressed: () {
                      Get.to(() => const DealsPage(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 600));
                    },
                    icon: const Icon(Icons.arrow_forward));
              },
            )
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
              width: 270,
              height: 220,
              child: PageView.builder(
                  scrollBehavior: const ScrollBehavior(),
                  onPageChanged: (value) {
                    currentCard.value = value;
                  },
                  controller: pageController,
                  clipBehavior: Clip.none,
                  itemCount: middleList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => BannerItems(
                      paddingImage: const EdgeInsets.only(right: 10),
                      paddingText: const EdgeInsets.only(left: 3),
                      foodImage: middleList[index].foodOrder,
                      deliveryTime: middleList[index].time,
                      shopName: middleList[index].shopName,
                      shopAddress: middleList[index].place,
                      rateStar: middleList[index].vote,
                      action: () {
                        check(index);
                      },
                      heartColor: like[index]))))
    ]);
  }
}
