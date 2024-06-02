part of 'restaurant_page.dart';

class RestaurantAppBar extends StatelessWidget {
  const RestaurantAppBar(
      {super.key,
      required this.image,
      required this.name,
      required this.place,
      required this.restaurant});

  final RestaurantModel restaurant;
  final String image, name, place;

  @override
  Widget build(BuildContext context) {
    final restaurantPageBloc = context.read<RestaurantPageBloc>();
    return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        color: AppColor.globalPink,
                        onPressed: null,
                        icon: SavedListData.saveFood.contains(restaurant)
                            ? const Icon(
                                Icons.favorite,
                                color: AppColor.globalPink,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          restaurantPageBloc.add(
                              RestaurantPageShareEvent(restaurant: restaurant));
                        },
                        child: Image.asset(
                          Assets.shareNetwork,
                          color: Colors.white,
                          height: 22,
                          width: 22,
                        ),
                      ),
                      PopupMenuButton(
                        iconSize: 30,
                        iconColor: Colors.white,
                        color: AppColor.dividerGrey,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {},
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Report'),
                                icon: const Icon(Icons.flag),
                              )),
                          PopupMenuItem(
                              onTap: () {
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          titlePadding: const EdgeInsets.only(
                                              left: 10, top: 24, right: 24),
                                          title: CupertinoTextFormFieldRow(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(24)),
                                            controller: restaurantPageBloc
                                                .reviewController,
                                            maxLines: 5,
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24),
                                              child: RatingBar.builder(
                                                itemSize: 22,
                                                initialRating:
                                                    restaurantPageBloc.rate,
                                                minRating: 1,
                                                maxRating: 5,
                                                unratedColor: Colors.grey,
                                                updateOnDrag: true,
                                                itemBuilder: (context, index) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                onRatingUpdate: (value) {
                                                  restaurantPageBloc.add(
                                                      RestaurantPageSetRateEvent(
                                                          rate: value));
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  restaurantPageBloc.add(
                                                      RestaurantPageSentReviewEvent(
                                                          restaurant:
                                                              restaurant,
                                                          reviewController:
                                                              restaurantPageBloc
                                                                  .reviewController,
                                                          rate:
                                                              restaurantPageBloc
                                                                  .rate,
                                                          context: context));
                                                },
                                                child: RiveAnimations
                                                    .reviewAnimation())
                                          ],
                                        ));
                              },
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Review'),
                                icon: const Icon(Icons.rate_review),
                              )),
                          PopupMenuItem(
                              onTap: () {
                                restaurantPageBloc
                                    .add(RestaurantPageMapEvent());
                              },
                              padding: EdgeInsets.zero,
                              child: TextButton.icon(
                                onPressed: null,
                                label: const CustomText(content: 'Map'),
                                icon: const Icon(Icons.location_on),
                              )),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 21),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          content: name,
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      CustomText(
                          content: place, color: Colors.white, fontSize: 15)
                    ]))
          ],
        ));
  }
}
