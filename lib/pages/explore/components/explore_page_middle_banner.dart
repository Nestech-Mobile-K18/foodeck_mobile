import 'package:template/source/export.dart';

class MiddleSlideList extends StatelessWidget {
  const MiddleSlideList({super.key});

  @override
  Widget build(BuildContext context) {
    final explorePageBloc = context.read<ExplorePageBloc>();
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
              child: CustomSlidePage(
                  itemCount:
                      RestaurantData.kindFood(TitleFood.Deals, RestaurantData.restaurant)
                          .length,
                  itemBuilder: (context, index) => BannerItems(
                      onTap: () => explorePageBloc.add(ExplorePageNavigateEvent(
                          restaurantModel: RestaurantData.kindFood(
                              TitleFood.Deals,
                              RestaurantData.restaurant)[index])),
                      paddingImage: const EdgeInsets.only(right: 10),
                      paddingText: const EdgeInsets.only(left: 3),
                      foodImage: RestaurantData.kindFood(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .image,
                      deliveryTime:
                          '${RestaurantData.kindFood(TitleFood.Deals, RestaurantData.restaurant)[index].deliveryTime} mins',
                      shopName: RestaurantData.kindFood(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .shopName,
                      shopAddress: RestaurantData.kindFood(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .address,
                      rateStar: '${RestaurantData.kindFood(TitleFood.Deals, RestaurantData.restaurant)[index].rate}',
                      action: () {
                        explorePageBloc.add(ExplorePageLikeEvent(
                            saveFood: RestaurantData.kindFood(TitleFood.Deals,
                                RestaurantData.restaurant)[index]));
                      },
                      restaurantModel: RestaurantData.kindFood(TitleFood.Deals, RestaurantData.restaurant)[index]))))
    ]);
  }
}
