import 'package:flutter/material.dart';

import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';

class TabBeverages extends StatefulWidget {
  final List<Map<String, dynamic>>? listFoods;
  const TabBeverages({super.key, this.listFoods});

  @override
  State<TabBeverages> createState() => _TabBeveragesState();
}

class _TabBeveragesState extends State<TabBeverages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              title: 'Wraps',
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
                      return Padding(
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
                                  width:
                                      Responsive.blockSizeWidth(context) * 0.6,
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
