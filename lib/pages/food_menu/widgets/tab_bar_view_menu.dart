import 'package:flutter/material.dart';
import 'package:template/pages/food_menu/widgets/tab_beverages.dart';
import 'package:template/pages/food_menu/widgets/tab_deals.dart';
import 'package:template/pages/food_menu/widgets/tab_popular.dart';
import 'package:template/pages/food_menu/widgets/tab_sandwiches.dart';
import 'package:template/pages/food_menu/widgets/tab_wraps.dart';

import '../../../resources/const.dart';

class TabBarViewMenu extends StatefulWidget {
  final TabController? controller;
  final List<Map<String, dynamic>>? listFoodsPopular;
  final List<Map<String, dynamic>>? listFoodDeals;
  final List<Map<String, dynamic>>? listFoodWraps;
  final List<Map<String, dynamic>>? listFoodBeverages;
  final List<Map<String, dynamic>>? listFoodSanwiches;
  const TabBarViewMenu(
      {super.key,
      required this.controller,
      this.listFoodsPopular,
      this.listFoodWraps,
      this.listFoodBeverages,
      this.listFoodSanwiches,
      this.listFoodDeals});

  @override
  State<TabBarViewMenu> createState() => _TabBarViewMenuState();
}

class _TabBarViewMenuState extends State<TabBarViewMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Responsive.screenHeight(context) * 0.58,
        width: Responsive.screenWidth(context),
        color: Colors.white,
        child: TabBarView(
          controller: widget.controller,
          children: [
            TabPopular(listFoods: widget.listFoodsPopular),
            TabDeals(listFoods: widget.listFoodDeals),
            TabWraps(listFoods: widget.listFoodWraps),
            TabBeverages(listFoods: widget.listFoodBeverages),
            TabSandwiches(listFoods: widget.listFoodSanwiches),
          ],
        ));
  }
}
