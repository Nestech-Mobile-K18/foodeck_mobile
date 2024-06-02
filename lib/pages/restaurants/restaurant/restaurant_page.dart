import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

part 'restaurant_extension_appbar.dart';
part 'restaurant_extension_bottom_app_bar.dart';
part 'restaurant_extension_food.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});

  final RestaurantModel restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  void initState() {
    context
        .read<RestaurantPageBloc>()
        .add(RestaurantPageInitialEvent(restaurant: widget.restaurant));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantPageBloc = context.read<RestaurantPageBloc>();
    return BlocConsumer<RestaurantPageBloc, RestaurantPageState>(
      listenWhen: (previous, current) => current is RestaurantPageActionState,
      buildWhen: (previous, current) => current is! RestaurantPageActionState,
      listener: (context, state) async {
        if (state is RestaurantPageShareState) {
          await Share.share('text');
        } else if (state is RestaurantPageMapState) {
          Navigator.pushNamed(context, AppRouter.myLocation);
        } else if (state is RestaurantPageNavigateToAddonState) {
          Navigator.pushNamed(context, AppRouter.restaurantAddon,
              arguments: RestaurantAddon(
                  foodItems: state.foodItems, restaurant: state.restaurant));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantPageInitial:
            return const LoadingAnimationRive();
          case RestaurantPageLoadingState:
            return const LoadingAnimationRive();
          case RestaurantPageLoadingSuccessState:
            final success = state as RestaurantPageLoadingSuccessState;
            return DefaultTabController(
              length: FoodCategory.values.length,
              child: Scaffold(
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 200,
                      flexibleSpace: RestaurantAppBar(
                          image: success.restaurant.image,
                          name: success.restaurant.shopName,
                          place: success.restaurant.address,
                          restaurant: success.restaurant)),
                  body: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                            RestaurantBottomAppBar(
                              restaurant: success.restaurant,
                            )
                          ],
                      body: TabBarView(
                          children: FoodCategory.values.map((category) {
                        List<FoodItems> categoryMenu =
                            RestaurantData.filterCategory(
                                category, RestaurantData.foodItems);
                        return ListView.builder(
                            itemCount: categoryMenu.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final food = categoryMenu[index];
                              return RestaurantFood(
                                  voidCallback: () {
                                    restaurantPageBloc.add(
                                        RestaurantPageNavigateToAddonEvent(
                                            foodItems: food,
                                            restaurant: success.restaurant));
                                  },
                                  foodItems: food);
                            });
                      }).toList()))),
            );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
