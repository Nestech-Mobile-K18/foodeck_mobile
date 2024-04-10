import 'package:flutter/material.dart';
import 'package:template/pages/deals/widget/list_food.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class AddCart extends StatefulWidget {
  const AddCart({super.key, required this.foodItems});

  final FoodItems foodItems;

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const UnderlineInputBorder(
            borderSide: BorderSide(width: 8, color: dividerGrey)),
        title: Text('Cart',
            style: inter.copyWith(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ListFood(
                      picture: widget.foodItems.picture,
                      nameFood: widget.foodItems.nameFood,
                      detail: widget.foodItems.detail,
                      price: widget.foodItems.price.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
