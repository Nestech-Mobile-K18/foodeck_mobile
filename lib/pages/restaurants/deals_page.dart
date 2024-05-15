import 'package:template/source/export.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({super.key, required this.desktopFood});

  final DesktopFood desktopFood;

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
              image: widget.desktopFood.foodOrder,
              name: widget.desktopFood.shopName,
              place: widget.desktopFood.place,
              desktopFood: widget.desktopFood,
            )),
        body: Consumer<Restaurant>(
          builder: (BuildContext context, Restaurant value, Widget? child) =>
              NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        CustomSliverBar(
                          desktopFood: widget.desktopFood,
                        )
                      ],
                  body: TabBarView(
                      children: value.sortFood(foodItems, widget.desktopFood))),
        ),
      ),
    );
  }
}
