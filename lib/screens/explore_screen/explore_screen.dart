import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/banner/list_banner.dart';
import 'package:foodeck_app/screens/explore_screen/deals/list_deals.dart';
import 'package:foodeck_app/screens/explore_screen/dessert_card.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/list_explore_more.dart';
import 'package:foodeck_app/screens/explore_screen/food_card.dart';
import 'package:foodeck_app/screens/explore_screen/grocery_card.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  //
  final TextEditingController searchController = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
              width: double.infinity,
            ),
            const FoodCard(),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GroceryCard(),
                  DessertCard(),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const ListBanner(),
            const SizedBox(
              height: 40,
            ),
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
                      // setState(() {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => FoodMenuScreen(
                      //               dealsItemInfo: dealsItemInfo[selected!])));
                      // });
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
            const ListDeals(),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 328,
              alignment: Alignment.centerLeft,
              child: Text(
                "Explore more",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const ListExploreMore(),
          ],
        ),
      ),
    );
  }
}
