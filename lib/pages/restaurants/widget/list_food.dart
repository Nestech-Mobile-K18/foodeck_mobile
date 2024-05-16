import 'package:template/source/export.dart';

class ListFood extends StatefulWidget {
  const ListFood({super.key, this.voidCallback, required this.foodItems});

  final VoidCallback? voidCallback;
  final FoodItems foodItems;

  @override
  State<ListFood> createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.voidCallback,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        width: 80,
                        height: 64,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: AssetImage(widget.foodItems.picture),
                                fit: BoxFit.cover))),
                    const SizedBox(width: 30),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(content: widget.foodItems.nameFood),
                          CustomText(
                              content: widget.foodItems.detail,
                              fontSize: 15,
                              color: Colors.grey),
                          const SizedBox(height: 20),
                          CustomText(
                              content: '\$${widget.foodItems.price}',
                              fontSize: 15,
                              fontWeight: FontWeight.bold)
                        ])
                  ]),
            ),
          ),
        ),
        Divider(color: Colors.grey[300])
      ],
    );
  }
}
