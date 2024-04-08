import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/cart_screen/drinks/drinks_card.dart';
import 'package:foodeck_app/screens/cart_screen/drinks/drinks_info.dart';

class ListDrinks extends StatefulWidget {
  const ListDrinks({super.key});

  @override
  State<ListDrinks> createState() => _ListDrinksState();
}

class _ListDrinksState extends State<ListDrinks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 230,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          itemCount: drinksInfo.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          dragStartBehavior: DragStartBehavior.start,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => DrinksCard(
            drinksInfo: drinksInfo[index],
          ),
        ),
      ),
    );
  }
}
