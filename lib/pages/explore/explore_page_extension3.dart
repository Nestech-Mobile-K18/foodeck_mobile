part of 'explore_page.dart';

class MiddleSlideList extends StatefulWidget {
  const MiddleSlideList({
    super.key,
    required this.explorePageBloc,
    required this.successState,
  });

  final ExplorePageLoadingSuccessState successState;
  final ExplorePageBloc explorePageBloc;

  @override
  State<MiddleSlideList> createState() => _MiddleSlideListState();
}

class _MiddleSlideListState extends State<MiddleSlideList> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);

  int currentCard = 0;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(content: 'Deals', fontWeight: FontWeight.bold),
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward))
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
              width: 270,
              height: 220,
              child: PageView.builder(
                  scrollBehavior: const ScrollBehavior(),
                  onPageChanged: (value) {
                    currentCard = value;
                  },
                  controller: pageController,
                  clipBehavior: Clip.none,
                  itemCount: RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)
                      .length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) => BannerItems(
                      onTap: () => widget.explorePageBloc.add(ExplorePageNavigateEvent(
                          restaurantModel: RestaurantData.kindFood(
                              TitleFood.Deals,
                              widget.successState.restaurant)[index])),
                      paddingImage: const EdgeInsets.only(right: 10),
                      paddingText: const EdgeInsets.only(left: 3),
                      foodImage: RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index]
                          .image,
                      deliveryTime:
                          '${RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index].deliveryTime} mins',
                      shopName: RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index]
                          .shopName,
                      shopAddress: RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index]
                          .address,
                      rateStar:
                          '${RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index].rate}',
                      action: () {
                        widget.explorePageBloc.add(ExplorePageLikeEvent(
                            saveFood: RestaurantData.kindFood(TitleFood.Deals,
                                widget.successState.restaurant)[index]));
                      },
                      iconShape: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index])
                          ? Icons.favorite
                          : Icons.favorite_border,
                      heartColor: SavedListData.saveFood.contains(RestaurantData.kindFood(TitleFood.Deals, widget.successState.restaurant)[index])
                          ? AppColor.globalPink
                          : Colors.white))))
    ]);
  }
}
