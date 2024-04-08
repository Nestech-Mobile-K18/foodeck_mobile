import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/drinks/drinks_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DrinksCard extends StatefulWidget {
  final DrinksInfo drinksInfo;
  const DrinksCard({super.key, required this.drinksInfo});

  @override
  State<DrinksCard> createState() => _DrinksCardState();
}

class _DrinksCardState extends State<DrinksCard> {
  //
  void _savedItem() {}
  //
  void _unsavedItem() {}
  //
  void _addDrink() {}

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 240,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 328,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(widget.drinksInfo.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, top: 120),
                  width: 38,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.white,
                  ),
                  child: Text(
                    "\$${widget.drinksInfo.price.toStringAsFixed(0)}",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.drinksInfo.like == false
                          ? AppColor.white.withOpacity(0.3)
                          : AppColor.primary.withOpacity(0.3),
                    ),
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      isSelected: widget.drinksInfo.like,
                      onPressed: () {
                        setState(() {
                          widget.drinksInfo.like = !widget.drinksInfo.like;
                          _savedItem();
                          _unsavedItem();
                        });
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                        size: 15,
                        color: AppColor.white,
                      ),
                      selectedIcon: Icon(
                        Icons.favorite,
                        size: 15,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 5,
            ),
            width: 328,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.drinksInfo.title,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      widget.drinksInfo.location,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey1,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _addDrink,
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: AppColor.grey1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
