import 'package:template/source/export.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: FoodCategory.values.length,
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              flexibleSpace: DetailAppBar(
                image: widget.restaurant.image,
                name: widget.restaurant.shopName,
                place: widget.restaurant.address,
                restaurant: widget.restaurant,
              )),
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    CustomSliverBar(
                      restaurant: widget.restaurant,
                    )
                  ],
              body: TabBarView(
                  children: FoodCategory.values.map((category) {
                List<FoodItems> categoryMenu = RestaurantData.filterCategory(
                    category, RestaurantData.foodItems);
                return ListView.builder(
                    itemCount: categoryMenu.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final food = categoryMenu[index];
                      return ListFood(
                          voidCallback: () {
                            Navigator.pushNamed(context, AppRouter.detailFood,
                                arguments: DetailFood(
                                    foodItems: food,
                                    restaurant: widget.restaurant));
                          },
                          foodItems: food);
                    });
              }).toList()))),
    );
  }
}
