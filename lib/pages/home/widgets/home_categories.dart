import 'package:flutter/material.dart';
import 'package:template/pages/home/widgets/home_card.dart';

import '../../../resources/const.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HomeCard(
          imgString: MediaRes.food,
          headerText: StringExtensions.food,
          contentText: StringExtensions.contentFood,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: HomeCard(
                imgString: MediaRes.grocery,
                headerText: StringExtensions.food,
                contentText: StringExtensions.contentFood,
                heightCard: 180,
                widthCard: 180,
              ),
            ),
            Expanded(
              flex: 1,
              child: HomeCard(
                imgString: MediaRes.deserts,
                headerText: StringExtensions.food,
                contentText: StringExtensions.contentFood,
                heightCard: 180,
                widthCard: 180,
              ),
            ),
          ],
        )
      ],
    );
  }
}
