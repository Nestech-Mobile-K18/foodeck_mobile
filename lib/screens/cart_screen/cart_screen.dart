import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/cart_card.dart';
import 'package:foodeck_app/screens/cart_screen/cart_item_info.dart';
import 'package:foodeck_app/widgets/header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Header(
          headerTitle: "Cart",
          onBack: () {
            Navigator.pop(context);
            print("object");
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
              width: double.infinity,
            ),
            SizedBox(
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: cartItemInfo.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CartCard(
                  cartItemInfo: cartItemInfo[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
