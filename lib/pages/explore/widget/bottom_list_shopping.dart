import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/models/desktop_food.dart';
import 'package:template/pages/deals/deals_page.dart';
import 'package:template/pages/explore/widget/banner_items.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class BottomListShopping extends StatefulWidget {
  const BottomListShopping({
    super.key,
  });

  @override
  State<BottomListShopping> createState() => _BottomListShoppingState();
}

class _BottomListShoppingState extends State<BottomListShopping> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TopFood>(
        builder: (BuildContext context, value, Widget? child) {
      Future saveBanner(index) async {
        try {
          await supabase.from('items').upsert({
            'food':
                value.kindFood(TitleFood.Explore, desktopFood)[index].foodOrder,
            'time_delivery':
                value.kindFood(TitleFood.Explore, desktopFood)[index].time,
            'shop_name':
                value.kindFood(TitleFood.Explore, desktopFood)[index].shopName,
            'place':
                value.kindFood(TitleFood.Explore, desktopFood)[index].place,
            'vote': value.kindFood(TitleFood.Explore, desktopFood)[index].vote
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: globalPinkShadow,
                  content: Text('You just liked this item'))));
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text(error.message)));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text('Error occurred, please retry')));
        }
      }

      Future deleteBanner(index) async {
        try {
          await supabase.from('items').delete().match({
            'food':
                value.kindFood(TitleFood.Explore, desktopFood)[index].foodOrder,
            'time_delivery':
                value.kindFood(TitleFood.Explore, desktopFood)[index].time,
            'shop_name':
                value.kindFood(TitleFood.Explore, desktopFood)[index].shopName,
            'place':
                value.kindFood(TitleFood.Explore, desktopFood)[index].place,
            'vote': value.kindFood(TitleFood.Explore, desktopFood)[index].vote
          }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  duration: Duration(milliseconds: 1500),
                  backgroundColor: buttonShadowBlack,
                  content: Text('You just unliked this item'))));
        } on AuthException catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text(error.message)));
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: buttonShadowBlack,
              content: Text('Error occurred, please retry')));
        }
      }

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
                    itemCount:
                        value.kindFood(TitleFood.Explore, desktopFood).length,
                    scrollDirection: Axis.vertical,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: BannerItems(
                            onTap: () => Get.to(() => DealsPage(
                                  desktopFood: value.kindFood(
                                      TitleFood.Explore, desktopFood)[index],
                                )),
                            foodImage: value
                                .kindFood(TitleFood.Explore, desktopFood)[index]
                                .foodOrder,
                            deliveryTime: value
                                .kindFood(TitleFood.Explore, desktopFood)[index]
                                .time,
                            shopName: value
                                .kindFood(TitleFood.Explore, desktopFood)[index]
                                .shopName,
                            shopAddress: value
                                .kindFood(TitleFood.Explore, desktopFood)[index]
                                .place,
                            rateStar: value
                                .kindFood(TitleFood.Explore, desktopFood)[index]
                                .vote,
                            action: () {
                              if (!value.saveFood.contains(value.kindFood(
                                  TitleFood.Explore, desktopFood)[index])) {
                                value.addToList(value.kindFood(
                                    TitleFood.Explore, desktopFood)[index]);
                                saveBanner(index);
                              } else {
                                value.removeFromList(value.kindFood(
                                    TitleFood.Explore, desktopFood)[index]);
                                deleteBanner(index);
                              }
                            },
                            iconShape: value.saveFood.contains(value.kindFood(
                                    TitleFood.Explore, desktopFood)[index])
                                ? Icons.favorite
                                : Icons.favorite_border,
                            heartColor: value.saveFood.contains(value.kindFood(
                                    TitleFood.Explore, desktopFood)[index])
                                ? globalPink
                                : Colors.white)))))
      ]);
    });
  }
}
