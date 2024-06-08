import 'package:template/source/export.dart';

class BottomListShopping extends StatelessWidget {
  const BottomListShopping({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomText(content: 'Explore More', fontWeight: FontWeight.bold),
      Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
              height: 674,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: RestaurantData.kindFood(
                          TitleFood.Explore, RestaurantData.restaurant)
                      .length,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BannerItems(
                          onTap: () => explorePageBloc.add(ExplorePageNavigateEvent(
                              restaurantModel: RestaurantData.kindFood(
                                  TitleFood.Explore,
                                  RestaurantData.restaurant)[index])),
                          foodImage: RestaurantData.kindFood(TitleFood.Explore,
                                  RestaurantData.restaurant)[index]
                              .image,
                          deliveryTime:
                              '${RestaurantData.kindFood(TitleFood.Explore, RestaurantData.restaurant)[index].deliveryTime} mins',
                          shopName: RestaurantData.kindFood(
                                  TitleFood.Explore, RestaurantData.restaurant)[index]
                              .shopName,
                          shopAddress: RestaurantData.kindFood(TitleFood.Explore, RestaurantData.restaurant)[index].address,
                          rateStar: '${RestaurantData.kindFood(TitleFood.Explore, RestaurantData.restaurant)[index].rate}',
                          action: () {
                            explorePageBloc.add(ExplorePageLikeEvent(
                                saveFood: RestaurantData.kindFood(
                                    TitleFood.Explore,
                                    RestaurantData.restaurant)[index]));
                          },
                          restaurantModel: RestaurantData.kindFood(TitleFood.Explore, RestaurantData.restaurant)[index])))))
    ]);
  }
}
