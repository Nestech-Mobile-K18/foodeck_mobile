part of 'explore_page.dart';

class BottomListShopping extends StatelessWidget {
  const BottomListShopping({super.key, required this.successState});

  final ExplorePageLoadingSuccessState successState;

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
                  itemCount: RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)
                      .length,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BannerItems(
                          onTap: () => explorePageBloc.add(ExplorePageNavigateEvent(
                              restaurantModel: RestaurantData.kindFood(
                                  TitleFood.Explore,
                                  successState.restaurant)[index])),
                          foodImage: RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index]
                              .image,
                          deliveryTime:
                              '${RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index].deliveryTime} mins',
                          shopName: RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index]
                              .shopName,
                          shopAddress:
                              RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index]
                                  .address,
                          rateStar:
                              '${RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index].rate}',
                          action: () {
                            explorePageBloc.add(ExplorePageLikeEvent(
                                saveFood: RestaurantData.kindFood(
                                    TitleFood.Explore,
                                    successState.restaurant)[index]));
                          },
                          iconShape: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          heartColor: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Explore, successState.restaurant)[index])
                              ? AppColor.globalPink
                              : Colors.white)))))
    ]);
  }
}
