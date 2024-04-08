import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_item_card.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_item_infomation.dart';
import 'package:foodeck_app/screens/food_menu_screen/populars_tab/populars_item_card.dart';
import 'package:foodeck_app/screens/food_menu_screen/populars_tab/populars_item_info.dart';
import 'package:foodeck_app/screens/food_variantions_screen/food_variations_screen.dart';

import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppularsTab extends StatefulWidget {
  final String location;
  const PoppularsTab({super.key, required this.location});

  @override
  State<PoppularsTab> createState() => _PoppularsTabState();
}

class _PoppularsTabState extends State<PoppularsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
            width: double.infinity,
          ),
          SizedBox(
            width: 328,
            child: Text(
              "Poppular",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColor.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.zero,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: popularsItemInfo.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodVariantionsScreen(
                                dealsItemInfo: dealsItemInfo[index],
                                exploreMoreItemInfo: null,
                                dealsItemInfomation: null,
                                popularsItemInfo: popularsItemInfo[index],
                                location: widget.location,
                              )));
                },
                child: PopularsItemCard(
                  popularsItemInfo: popularsItemInfo[index],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0),
            height: 8,
            color: AppColor.grey6,
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 328,
            child: Text(
              "Deals",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColor.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: dealsItemInfomation.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodVariantionsScreen(
                                      dealsItemInfo: dealsItemInfo[index],
                                      exploreMoreItemInfo: null,
                                      dealsItemInfomation:
                                          dealsItemInfomation[index],
                                      popularsItemInfo: null,
                                      location: widget.location,
                                    )));
                      },
                      child: DealsItemCard(
                        dealsItemInfomation: dealsItemInfomation[index],
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
