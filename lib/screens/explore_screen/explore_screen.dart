import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/screens/cart_screen/cart_screen.dart';
import 'package:foodeck_app/screens/explore_screen/banner/list_banner.dart';
import 'package:foodeck_app/screens/explore_screen/deals/list_deals.dart';
import 'package:foodeck_app/screens/explore_screen/dessert/dessert_card.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/list_explore_more.dart';
import 'package:foodeck_app/screens/explore_screen/food/food_card.dart';
import 'package:foodeck_app/screens/explore_screen/grocery/grocery_card.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreen extends StatefulWidget {
  final CartItemInfo? cartItemInfo;
  const ExploreScreen({
    super.key,
    this.cartItemInfo,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  //
  final TextEditingController searchController = TextEditingController();

  //show Dialog when cart is emty and user still press
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.grey1.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Icon(
                Icons.no_food,
                size: 24,
                color: AppColor.red,
              ),
              Text(
                "You have no item to buy today!",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).timeout(
      const Duration(seconds: 1),
      onTimeout: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }

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
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {
            cartItemInfo.isEmpty
                ? _showDialog()
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
          });
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const SizedBox(
              height: 65,
            ),
            SizedBox(
              height: 54,
              width: 54,
              child: CircleAvatar(
                backgroundColor: AppColor.primary,
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 22,
                  color: AppColor.white,
                ),
              ),
            ),
            cartItemInfo.isEmpty
                ? const SizedBox()
                : Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 22,
                      width: (cartItemInfo.fold(
                                      0,
                                      (previousValue, element) =>
                                          (previousValue + element.quantity)))
                                  .toInt() >=
                              100
                          ? 22 * 2
                          : 22,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.white,
                      ),
                      child: Container(
                        height: 18,
                        width: (cartItemInfo.fold(
                                        0,
                                        (previousValue, element) =>
                                            (previousValue + element.quantity)))
                                    .toInt() >=
                                100
                            ? 18 * 2
                            : 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.black,
                        ),
                        child: Text(
                          (cartItemInfo.fold(
                                  0,
                                  (previousValue, element) =>
                                      (previousValue + element.quantity)))
                              .toString(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
