part of 'explore_page.dart';

class TopListShopping extends StatelessWidget {
  const TopListShopping({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      buildCard(Assets.food, 'Food', 'Order Food You Love', double.maxFinite),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCard(Assets.grocery, 'Grocery', 'Shop daily life items', 156),
            buildCard(Assets.desert, 'Deserts', 'Something Sweet', 156)
          ],
        ),
      )
    ]);
  }

  Card buildCard(String image, String tittle, String content, double width) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(children: [
        Container(
          height: 160,
          width: width,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(content: tittle, color: Colors.white),
            CustomText(content: content, fontSize: 12, color: Colors.white)
          ]),
        )
      ]),
    );
  }
}
