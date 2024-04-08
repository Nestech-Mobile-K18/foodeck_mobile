import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart/cart_item_info.dart';
import 'package:foodeck_app/screens/cart_screen/cart_screen.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatefulWidget {
  final CartItemInfo cartItemInfo;
  const CartCard({super.key, required this.cartItemInfo});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  //
  void _deletedCart() {
    setState(() {
      cartItemInfo.removeWhere(
          (cartItemInfo) => widget.cartItemInfo.id == cartItemInfo.id);

      //
      cartItemInfo.isEmpty
          ? showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: Container(
                  height: 120,
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
                        Icons.remove_shopping_cart,
                        size: 24,
                        color: AppColor.red,
                      ),
                      Text(
                        "Item is empty!",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Please add the items to continue shopping",
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
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen(page: 0)));
                  });
                });
              },
            )
          //
          : Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 328,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(
                          widget.cartItemInfo.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 22,
                      width: widget.cartItemInfo.quantity >= 100 ? 22 * 2 : 22,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.white,
                      ),
                      child: Container(
                        height: 18,
                        width:
                            widget.cartItemInfo.quantity >= 100 ? 18 * 2 : 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.black,
                        ),
                        child: Text(
                          widget.cartItemInfo.quantity.toString(),
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
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.cartItemInfo.name,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      widget.cartItemInfo.sauce.isEmpty
                          ? "${widget.cartItemInfo.size}•No sauce"
                          : "${widget.cartItemInfo.size}•${widget.cartItemInfo.sauce}",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey1,
                      ),
                    ),
                    Text(
                      "\$${widget.cartItemInfo.price}",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _deletedCart();
                  });
                },
                child: Container(
                  height: 17,
                  width: 17,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.grey5,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 10,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          height: 16,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Divider(
            height: 1,
            color: AppColor.grey6,
          ),
        ),
      ],
    );
  }
}
