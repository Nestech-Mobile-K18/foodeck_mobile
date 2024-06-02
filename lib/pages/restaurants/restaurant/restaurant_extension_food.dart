part of 'restaurant_page.dart';

class RestaurantFood extends StatelessWidget {
  const RestaurantFood({super.key, this.voidCallback, required this.foodItems});

  final VoidCallback? voidCallback;
  final FoodItems foodItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: voidCallback,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: ListTile(
                title: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: AssetImage(foodItems.picture),
                              fit: BoxFit.cover))),
                  const SizedBox(width: 20),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(content: foodItems.nameFood),
                        CustomText(
                            content: foodItems.detail,
                            fontSize: 15,
                            color: Colors.grey),
                        const SizedBox(height: 20),
                        CustomText(
                            content: '\$${foodItems.price}',
                            fontSize: 15,
                            fontWeight: FontWeight.bold)
                      ]),
                ],
              ),
            )),
          ),
        ),
        Divider(color: Colors.grey[300])
      ],
    );
  }
}
