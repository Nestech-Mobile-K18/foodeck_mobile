import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_card.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/food_menu_screen/food_menu_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDeals extends StatefulWidget {
  const ListDeals({
    super.key,
  });

  @override
  State<ListDeals> createState() => _ListDealsState();
}

class _ListDealsState extends State<ListDeals> {
  //

  int? selectedDeal;
  //

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 328,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Deals",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodMenuScreen(
                                  dealsItemInfo: dealsItemInfo[selectedDeal!],
                                  exploreMoreItemInfo: null,
                                )));
                  });
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 24,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30),
          padding: const EdgeInsets.all(0),
          height: 230,
          width: dealsItemInfo.length.toDouble() * 240,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListView.builder(
              itemCount: dealsItemInfo.length,
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.start,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => DealsCard(
                dealsItemInfo: dealsItemInfo[index],
                selectedDeal: selectedDeal == index,
                onTapChooseDeal: (value) {
                  setState(() {
                    selectedDeal = index;
                  });
                },

                // ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
