import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/explore_screen/deals/deals_item_info.dart';
import 'package:foodeck_app/screens/explore_screen/explore_more/explore_more_item_info.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_item_infomation.dart';
import 'package:foodeck_app/screens/food_menu_screen/populars_tab/populars_item_info.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cart_screen/cart_screen.dart';

class FoodVariantionsScreen extends StatefulWidget {
  final String location;
  final DealsItemInfo? dealsItemInfo;
  final ExploreMoreItemInfo? exploreMoreItemInfo;
  final DealsItemInfomation? dealsItemInfomation;
  final PopularsItemInfo? popularsItemInfo;
  const FoodVariantionsScreen({
    super.key,
    required this.dealsItemInfo,
    required this.exploreMoreItemInfo,
    required this.dealsItemInfomation,
    this.popularsItemInfo,
    required this.location,
  });

  @override
  State<FoodVariantionsScreen> createState() => _FoodVariantionsScreenState();
}

class _FoodVariantionsScreenState extends State<FoodVariantionsScreen> {
  //
  bool savedDeals = false;
//
  void savedDealItem() {
    final newSavedDealItem = SavedItemInfo(
      image: widget.dealsItemInfo!.image,
      time: widget.dealsItemInfo!.time,
      title: widget.dealsItemInfo!.title,
      location: widget.dealsItemInfo!.location,
      star: widget.dealsItemInfo!.star,
    );
    savedDeals == true
        ? setState(() {
            savedItems.add(newSavedDealItem);
          })
        : null;
  }

  void unsavedDealItem() {
    savedDeals == false
        ? setState(() {
            savedItems.removeWhere((savedItems) =>
                savedItems.title == widget.dealsItemInfo!.title);
          })
        : null;
  }

  //
  bool isSelected8 = false;
  bool isSelected10 = false;
  bool isSelected12 = false;
  void selected(String selected) {
    setState(() {
      isSelected8 = false;
      isSelected10 = false;
      isSelected12 = false;
    });
    switch (selected) {
      case "8":
        isSelected8 = true;
        break;
      case "10":
        isSelected10 = true;
        break;
      case "12":
        isSelected12 = true;
        break;
    }
  }

  //
  bool texasBarbequeSauceSelected = false;
  bool charDonaySauceSelected = false;

  //
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  //
  TextEditingController intructionController = TextEditingController();
  @override
  void initState() {
    intructionController;
    super.initState();
  }

  @override
  void dispose() {
    intructionController.dispose();
    super.dispose();
  }

  //
  int price8 = 10;
  int price10 = 12;
  int price12 = 16;
  int texasSaucePrice = 6;
  int charSaucePrice = 8;
  //
  String exceptionText = "";

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Image.asset(
                widget.dealsItemInfomation != null
                    ? widget.dealsItemInfomation!.image
                    : widget.popularsItemInfo != null
                        ? widget.popularsItemInfo!.image
                        : "",
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                margin: EdgeInsets.zero,
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(1, 1, 1, 0.7), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.2, 1],
                  ),
                ),
              ),
              Positioned(
                bottom: 21,
                left: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.dealsItemInfomation != null
                          ? widget.dealsItemInfomation!.name
                          : widget.popularsItemInfo != null
                              ? widget.popularsItemInfo!.name
                              : "",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                    Text(
                      widget.location,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          leading: BackButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            color: AppColor.white,
          ),
          actions: [
            IconButton(
              alignment: Alignment.center,
              isSelected: savedDeals,
              onPressed: () {
                savedDeals = !savedDeals;
                savedDealItem();
                unsavedDealItem();
              },
              icon: Icon(
                Icons.favorite_outline,
                size: 22,
                color: AppColor.white,
              ),
              selectedIcon: Icon(
                Icons.favorite,
                size: 22,
                color: AppColor.primary,
              ),
            ),
            IconButton(
              alignment: Alignment.center,
              onPressed: () {},
              icon: Icon(
                Icons.share_outlined,
                size: 22,
                color: AppColor.white,
              ),
            ),
            IconButton(
              alignment: Alignment.center,
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_outlined,
                size: 22,
                color: AppColor.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              height: 24,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Variation",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Required",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 54,
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selected("8");
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        shape: const CircleBorder(),
                        backgroundColor: isSelected8 == true
                            ? AppColor.primary
                            : AppColor.white,
                        side: BorderSide(
                          width: 1,
                          color: AppColor.grey1,
                        ),
                      ),
                      child: SizedBox(
                        height: 7,
                        width: 7,
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "8",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 240,
                  ),
                  Text(
                    "\$$price8",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            SizedBox(
              height: 54,
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selected("10");
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        shape: const CircleBorder(),
                        backgroundColor: isSelected10 == true
                            ? AppColor.primary
                            : AppColor.white,
                        side: BorderSide(
                          width: 1,
                          color: AppColor.grey1,
                        ),
                      ),
                      child: SizedBox(
                        height: 7,
                        width: 7,
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$price8\"",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 240,
                  ),
                  Text(
                    "\$12",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            SizedBox(
              height: 54,
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selected("12");
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        shape: const CircleBorder(),
                        backgroundColor: isSelected12 == true
                            ? AppColor.primary
                            : AppColor.white,
                        side: BorderSide(
                          width: 1,
                          color: AppColor.grey1,
                        ),
                      ),
                      child: SizedBox(
                        height: 7,
                        width: 7,
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$price12\"",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 240,
                  ),
                  Text(
                    "\$16",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
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
                "Quantity",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _counter > 0 ? _decrementCounter() : null;
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 18,
                      color: AppColor.grey1,
                    ),
                  ),
                  Text(
                    '$_counter',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: _incrementCounter,
                    icon: Icon(
                      Icons.add,
                      size: 18,
                      color: AppColor.grey1,
                    ),
                  ),
                ],
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
                "Extra Sauce",
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
            SizedBox(
              height: 54,
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      value: texasBarbequeSauceSelected,
                      onChanged: (value) {
                        setState(() {
                          texasBarbequeSauceSelected =
                              !texasBarbequeSauceSelected;
                        });
                      },
                      side: BorderSide(
                        width: 1,
                        color: AppColor.grey1,
                      ),
                      checkColor: AppColor.white,
                      activeColor: AppColor.primary,
                    ),
                  ),
                  Text(
                    "Texas Barbeque",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Text(
                    "+\$$texasSaucePrice",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 0),
              height: 1,
              color: AppColor.grey6,
            ),
            SizedBox(
              height: 54,
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      value: charDonaySauceSelected,
                      onChanged: (value) {
                        setState(() {
                          charDonaySauceSelected = !charDonaySauceSelected;
                        });
                      },
                      side: BorderSide(
                        width: 1,
                        color: AppColor.grey1,
                      ),
                      checkColor: AppColor.white,
                      activeColor: AppColor.primary,
                    ),
                  ),
                  Text(
                    "Char Donay",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  Text(
                    "+\$$charSaucePrice",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
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
                "Instructions",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 328,
              child: Text(
                "Let us know if you have specific things in mind",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey1,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              controller: intructionController,
              obscureText: false,
              errorText: "",
              hintText: "e.g. less spices, no mayo etc",
            ),
            const SizedBox(
              height: 24,
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
                "If the product is not available",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 54,
              width: 328,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 1,
                  color: AppColor.grey1,
                ),
              ),
              child: SizedBox(
                child: DropdownButton<String>(
                  value: exceptionText,
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                  items: <String>[
                    'Remove it from my order',
                    'Take my oder to waiting list',
                    'Call hotline'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      exceptionText = value!.toString().trim();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
              width: 328,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$${(isSelected8 == true ? _counter * price8 : isSelected10 == true ? _counter * price10 : isSelected12 == true ? _counter * price12 : 0) + (texasBarbequeSauceSelected == true ? texasSaucePrice : 0) + (charDonaySauceSelected == true ? charSaucePrice : 0)}",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      padding: EdgeInsets.zero,
                      fixedSize: const Size(137, 54),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    child: Text(
                      "Add to card",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
