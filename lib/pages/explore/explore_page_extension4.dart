part of 'explore_page.dart';

class BottomListShopping extends StatefulWidget {
  const BottomListShopping({
    super.key,
    required this.successState,
    required this.explorePageBloc,
  });

  final ExplorePageLoadingSuccessState successState;
  final ExplorePageBloc explorePageBloc;

  @override
  State<BottomListShopping> createState() => _BottomListShoppingState();
}

class _BottomListShoppingState extends State<BottomListShopping> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomText(content: 'Explore More', fontWeight: FontWeight.bold),
      Padding(
          padding: const EdgeInsets.only(top: 12),
          child: SizedBox(
              height: 674,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)
                      .length,
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BannerItems(
                          onTap: () => widget.explorePageBloc.add(
                              ExplorePageNavigateEvent(
                                  restaurantModel: RestaurantData.kindFood(
                                      TitleFood.Explore,
                                      widget.successState.restaurant)[index])),
                          foodImage: RestaurantData.kindFood(TitleFood.Explore,
                                  widget.successState.restaurant)[index]
                              .image,
                          deliveryTime:
                              '${RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)[index].deliveryTime} mins',
                          shopName: RestaurantData.kindFood(
                                  TitleFood.Explore, widget.successState.restaurant)[index]
                              .shopName,
                          shopAddress: RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)[index].address,
                          rateStar: '${RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)[index].rate}',
                          action: () {
                            widget.explorePageBloc.add(ExplorePageLikeEvent(
                                saveFood: RestaurantData.kindFood(
                                    TitleFood.Explore,
                                    widget.successState.restaurant)[index]));
                          },
                          iconShape: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)[index]) ? Icons.favorite : Icons.favorite_border,
                          heartColor: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Explore, widget.successState.restaurant)[index]) ? AppColor.globalPink : Colors.white)))))
    ]);
  }
}
