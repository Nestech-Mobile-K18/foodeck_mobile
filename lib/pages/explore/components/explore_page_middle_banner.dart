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
                      RestaurantData.sortRestaurant(TitleFood.Deals, RestaurantData.restaurant)
                          .length,
                  itemBuilder: (context, index) => BannerItems(
                      onTap: () => explorePageBloc.add(ExplorePageNavigateEvent(
                          restaurantModel: RestaurantData.sortRestaurant(
                              TitleFood.Deals,
                              RestaurantData.restaurant)[index])),
                      paddingImage: const EdgeInsets.only(right: 10),
                      paddingText: const EdgeInsets.only(left: 3),
                      foodImage: RestaurantData.sortRestaurant(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .image,
                      deliveryTime:
                          '${RestaurantData.sortRestaurant(TitleFood.Deals, RestaurantData.restaurant)[index].deliveryTime} mins',
                      shopName: RestaurantData.sortRestaurant(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .shopName,
                      shopAddress: RestaurantData.sortRestaurant(
                              TitleFood.Deals, RestaurantData.restaurant)[index]
                          .address,
                      rateStar: '${RestaurantData.sortRestaurant(TitleFood.Deals, RestaurantData.restaurant)[index].rate}',
                      action: () {
                        explorePageBloc.add(ExplorePageLikeEvent(
                            saveFood: RestaurantData.sortRestaurant(TitleFood.Deals,
                                RestaurantData.restaurant)[index]));
                      },
                      restaurantModel: RestaurantData.sortRestaurant(TitleFood.Deals, RestaurantData.restaurant)[index]))))
    ]);
  }
}
