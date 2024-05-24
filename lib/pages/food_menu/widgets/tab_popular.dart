import 'package:flutter/material.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

import '../views/food_variations_view.dart';


class TabPopular extends StatefulWidget {
  final List<Map<String, dynamic>>? listFoods;
  const TabPopular({super.key, this.listFoods});

  @override
  State<TabPopular> createState() => _TabPopularState();
}

class _TabPopularState extends State<TabPopular> {
  void _navigateToFoodVariations(BuildContext context, Map<String, dynamic> foodItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodVariationsView(bindingData: foodItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: 'Popular',
              color: ColorsGlobal.globalBlack,
              size: 20,
              fontWeight: FontWeight.w700,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.listFoods!.map((food) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...food['list_food'].map<Widget>((foodItem) {
                      return InkWell(
                        onTap: () => _navigateToFoodVariations(context, foodItem),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                            children: [
                              Container(
                                width: Responsive.blockSizeWidth(context) * 0.2,
                                height: Responsive.screenHeight(context) * 0.09,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(foodItem['image_food']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: foodItem['food_name'],
                                    size: 17,
                                    color: ColorsGlobal.globalBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    width: Responsive.blockSizeWidth(context) * 0.6,
                                    child: CustomText(
                                      title: foodItem['bonus'],
                                      maxLine: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      size: 15,
                                      color: ColorsGlobal.textGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  CustomText(
                                    title: '\$${foodItem['price']}',
                                    size: 15,
                                    color: ColorsGlobal.globalBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
