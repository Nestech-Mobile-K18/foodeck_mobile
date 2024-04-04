import 'package:flutter/material.dart';
import 'package:template/pages/deals/widget/list_food.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 900,
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Popular',
                    style: inter.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                ListFood(
                    picture: pizza,
                    nameFood: 'Chicken Fajita Pizza\n',
                    detail: '8” pizza with regular soft drink\n',
                    price: '\$10'),
                Divider(color: dividerGrey),
                ListFood(
                    picture: friedChicken,
                    nameFood: 'Chicken Fajita Pizza\n',
                    detail: '8” pizza with regular soft drink\n',
                    price: '\$10'),
                Divider(
                  thickness: 8,
                  color: dividerGrey,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text('Deals',
                      style: inter.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                ListFood(
                    picture: coffeeMilk,
                    nameFood: 'Deal 1\n',
                    detail: '1 regular burger with\ncroquette and hot cocoa\n',
                    price: '\$12'),
                Divider(color: dividerGrey),
                ListFood(
                    picture: hamburger,
                    nameFood: 'Deal 2\n',
                    detail: '1 regular burger with small fries\n',
                    price: '\$6'),
                Divider(color: dividerGrey),
                ListFood(
                    picture: simpleDesert,
                    nameFood: 'Deal 3\n',
                    detail: '2 pieces of beef stew with\nhomemade sauce\n',
                    price: '\$23')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
