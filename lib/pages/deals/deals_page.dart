import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:template/models/restaurant.dart';
import 'package:template/pages/deals/detail_page/detail_food.dart';
import 'package:template/pages/deals/widget/custom_sliver_appbar.dart';
import 'package:template/pages/deals/widget/list_food.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key, this.voidCallback});

  final VoidCallback? voidCallback;

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  List<FoodItems> _filterCategory(
      FoodCategory foodCategory, List<FoodItems> fullMenu) {
    return fullMenu.where((food) => food.foodCategory == foodCategory).toList();
  }

  List<Widget> sortFood(List<FoodItems> fullMenu) {
    return FoodCategory.values.map((category) {
      List<FoodItems> categoryMenu = _filterCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListFood(
            voidCallback: () {
              final food = categoryMenu[index];
              Get.to(
                  () => DetailFood(
                        foodItems: food,
                      ),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 600));
            },
            picture: categoryMenu[index].picture,
            nameFood: categoryMenu[index].nameFood,
            detail: categoryMenu[index].detail,
            price: categoryMenu[index].price),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FoodCategory.values.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          flexibleSpace: Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: AssetImage(widget.foodItems.foodOrder),
                  //     fit: BoxFit.cover)
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  shareNetwork,
                                  color: Colors.white,
                                  height: 22,
                                  width: 22,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  threeDots,
                                  height: 30,
                                  width: 30,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 21),
                    // child: RichText(
                    //     text: TextSpan(
                    //         text: widget.foodItems.shopName,
                    //         style: inter.copyWith(
                    //             fontSize: 22, fontWeight: FontWeight.bold),
                    //         children: [
                    //       TextSpan(
                    //           text: widget.foodItems.place,
                    //           style: inter.copyWith(
                    //               fontSize: 15, fontWeight: FontWeight.normal))
                    //     ])),
                  )
                ],
              )),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Consumer<Restaurant>(
            builder: (context, restaurant, child) => NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    [const CustomSliverBar()],
                body: TabBarView(children: sortFood(restaurant.menu))),
          ),
        ),
      ),
    );
  }
}
