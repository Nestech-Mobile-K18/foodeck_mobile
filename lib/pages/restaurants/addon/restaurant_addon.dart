import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class RestaurantAddon extends StatefulWidget {
  final FoodItems foodItems;
  final RestaurantModel restaurant;

  const RestaurantAddon(
      {super.key, required this.foodItems, required this.restaurant});

  @override
  State<RestaurantAddon> createState() => _RestaurantAddonState();
}

class _RestaurantAddonState extends State<RestaurantAddon> {
  late Timer timer;

  @override
  void initState() {
    context.read<RestaurantAddonBloc>().add(RestaurantAddonInitialEvent(
        restaurant: widget.restaurant, foodItems: widget.foodItems));
    super.initState();
  }

  void holdPressButtonDecrease(
      FoodItems foodItems, RestaurantModel restaurant) {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (foodItems.quantityFood > 1) {
        context.read<RestaurantAddonBloc>().add(
            RestaurantRepeatDecreaseQuantityEvent(
                foodItems: foodItems, restaurant: restaurant));
      } else {
        null;
      }
    });
  }

  void holdPressButtonIncrease(
      FoodItems foodItems, RestaurantModel restaurant) {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      context.read<RestaurantAddonBloc>().add(
          RestaurantRepeatIncreaseQuantityEvent(
              foodItems: foodItems, restaurant: restaurant));
    });
  }

  @override
  Widget build(BuildContext context) {
    final restaurantAddonBloc = context.read<RestaurantAddonBloc>();
    final restaurantPageBloc = context.read<RestaurantPageBloc>();
    return BlocConsumer<RestaurantAddonBloc, RestaurantAddonState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case RestaurantAddonLoadingState:
            return const LoadingAnimationRive();
          case RestaurantAddonLoadingSuccessState:
            final success = state as RestaurantAddonLoadingSuccessState;
            return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                      SliverAppBar(
                          backgroundColor: Colors.white,
                          expandedHeight: 200,
                          pinned: true,
                          automaticallyImplyLeading: false,
                          flexibleSpace: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            titlePadding: EdgeInsets.zero,
                            title: Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, bottom: 10, top: 21),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        content: success.foodItems.nameFood,
                                        fontSize: 22,
                                        color: AppColor.globalPink,
                                        fontWeight: FontWeight.bold),
                                    CustomText(
                                        content: success.foodItems.place,
                                        color: AppColor.globalPink,
                                        fontSize: 15)
                                  ]),
                            ),
                            background: Container(
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            success.foodItems.picture),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 40),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              icon: SavedListData.saveFood
                                                      .contains(
                                                          success.restaurant)
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color:
                                                          AppColor.globalPink,
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
                                                    RestaurantPageShareEvent(
                                                        restaurant: success
                                                            .restaurant));
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
                                                      label: const CustomText(
                                                          content: 'Report'),
                                                      icon: const Icon(
                                                          Icons.flag),
                                                    )),
                                                PopupMenuItem(
                                                    onTap: () {
                                                      showCupertinoModalPopup(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  SimpleDialog(
                                                                    titlePadding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        top: 24,
                                                                        right:
                                                                            24),
                                                                    title:
                                                                        CupertinoTextFormFieldRow(
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color: Colors
                                                                                  .grey.shade300),
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(24)),
                                                                      controller:
                                                                          restaurantPageBloc
                                                                              .reviewController,
                                                                      maxLines:
                                                                          5,
                                                                    ),
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                24),
                                                                        child: RatingBar
                                                                            .builder(
                                                                          itemSize:
                                                                              22,
                                                                          initialRating:
                                                                              restaurantPageBloc.rate,
                                                                          minRating:
                                                                              1,
                                                                          maxRating:
                                                                              5,
                                                                          unratedColor:
                                                                              Colors.grey,
                                                                          updateOnDrag:
                                                                              true,
                                                                          itemBuilder: (context, index) =>
                                                                              const Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Colors.yellow,
                                                                          ),
                                                                          onRatingUpdate:
                                                                              (value) {
                                                                            restaurantPageBloc.add(RestaurantPageSetRateEvent(rate: value));
                                                                          },
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            restaurantPageBloc.add(RestaurantPageSentReviewEvent(
                                                                                restaurant: success.restaurant,
                                                                                reviewController: restaurantPageBloc.reviewController,
                                                                                rate: restaurantPageBloc.rate,
                                                                                context: context));
                                                                          },
                                                                          child:
                                                                              RiveAnimations.reviewAnimation())
                                                                    ],
                                                                  ));
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    child: TextButton.icon(
                                                      onPressed: null,
                                                      label: const CustomText(
                                                          content: 'Review'),
                                                      icon: const Icon(
                                                          Icons.rate_review),
                                                    )),
                                                PopupMenuItem(
                                                    onTap: () {
                                                      restaurantPageBloc.add(
                                                          RestaurantPageMapEvent());
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    child: TextButton.icon(
                                                      onPressed: null,
                                                      label: const CustomText(
                                                          content: 'Map'),
                                                      icon: const Icon(
                                                          Icons.location_on),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ))
                    ],
                    body: SingleChildScrollView(
                      child: SizedBox(
                        height: 1300,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            SizedBox(
                                height: 310,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(24, 24, 24, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              content: 'Variation',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                            content: 'Required',
                                            color: AppColor.globalPink,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        height: 240,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: success.foodItems
                                                .availableAddons.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              Addon addon = success.foodItems
                                                  .availableAddons[index];
                                              return Column(
                                                children: [
                                                  RadioListTile.adaptive(
                                                    secondary: CustomText(
                                                        content:
                                                            '\$${addon.priceSize}'),
                                                    title: CustomText(
                                                        content: addon.size),
                                                    activeColor:
                                                        AppColor.globalPink,
                                                    value: addon.radio,
                                                    groupValue:
                                                        restaurantAddonBloc
                                                            .turnOn,
                                                    onChanged: (value) {
                                                      restaurantAddonBloc.add(
                                                          RestaurantPickSizeEvent(
                                                              turnOn: value!,
                                                              foodItems: success
                                                                  .foodItems,
                                                              restaurant: success
                                                                  .restaurant));
                                                    },
                                                  ),
                                                  RestaurantData.addonItems
                                                                  .length -
                                                              1 ==
                                                          index
                                                      ? const SizedBox()
                                                      : Divider(
                                                          color:
                                                              Colors.grey[300])
                                                ],
                                              );
                                            })),
                                    const Divider(
                                      thickness: 8,
                                      color: AppColor.dividerGrey,
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 180,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24, top: 24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                            content: 'Quantity',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 15),
                                          child: Container(
                                            height: 54,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade300),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTapDown: (details) {
                                                    holdPressButtonDecrease(
                                                        success.foodItems,
                                                        success.restaurant);
                                                  },
                                                  onTapCancel: () {
                                                    timer.cancel();
                                                  },
                                                  child: IconButton(
                                                      onPressed: () {
                                                        if (success.foodItems
                                                                .quantityFood >
                                                            1) {
                                                          restaurantAddonBloc.add(
                                                              RestaurantDecreaseQuantityEvent(
                                                                  foodItems: success
                                                                      .foodItems,
                                                                  restaurant:
                                                                      success
                                                                          .restaurant));
                                                        } else {
                                                          null;
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.remove)),
                                                ),
                                                CustomText(
                                                    content:
                                                        '${success.foodItems.quantityFood}'
                                                            .padLeft(2, '0')),
                                                GestureDetector(
                                                  onTapDown: (details) {
                                                    holdPressButtonIncrease(
                                                        success.foodItems,
                                                        success.restaurant);
                                                  },
                                                  onTapCancel: () {
                                                    timer.cancel();
                                                  },
                                                  child: IconButton(
                                                      onPressed: () {
                                                        restaurantAddonBloc.add(
                                                            RestaurantIncreaseQuantityEvent(
                                                                foodItems: success
                                                                    .foodItems,
                                                                restaurant: success
                                                                    .restaurant));
                                                      },
                                                      icon: const Icon(
                                                          Icons.add)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Divider(
                                      thickness: 8,
                                      color: AppColor.dividerGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 24),
                              child: SizedBox(
                                  height: 210,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 24),
                                        child: CustomText(
                                            content: 'Extra Sauce',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 130,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            itemCount:
                                                restaurantAddonBloc.like.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              Addon addon = success.foodItems
                                                  .availableAddons[index];
                                              return CheckboxListTile.adaptive(
                                                checkColor: Colors.white,
                                                activeColor:
                                                    AppColor.globalPink,
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                secondary: CustomText(
                                                    content:
                                                        '+\$${addon.price}',
                                                    color: Colors.grey),
                                                title: CustomText(
                                                    content: addon.addonName,
                                                    color: Colors.grey),
                                                value: restaurantAddonBloc
                                                    .like[index],
                                                onChanged: (bool? valueA) {
                                                  restaurantAddonBloc.add(
                                                      RestaurantPickAddonEvent(
                                                          index: index,
                                                          restaurant: success
                                                              .restaurant,
                                                          foodItems: success
                                                              .foodItems));
                                                },
                                              );
                                            }),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Divider(
                                          thickness: 8,
                                          color: AppColor.dividerGrey,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                      content: 'Instructions',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(height: 30),
                                  const CustomText(
                                      content:
                                          'Let us know if you have specific things in\nmind',
                                      color: Colors.grey),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24, bottom: 15),
                                    child: CustomFormFill(
                                      textEditingController:
                                          restaurantAddonBloc.noteController,
                                      borderColor: Colors.grey[400],
                                      hintText: 'e.g. less spices, no mayo etc',
                                      focusErrorBorderColor: Colors.grey[400],
                                      inputColor: Colors.grey[400],
                                      hintColor: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 8,
                              color: AppColor.dividerGrey,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 24),
                                      child: CustomText(
                                          content:
                                              'If the product is not available',
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24, bottom: 60),
                                    child: DropdownButtonFormField(
                                      iconEnabledColor: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20),
                                      hint: CustomText(
                                          content: 'Remove it from my order',
                                          color: Colors.grey.shade400),
                                      dropdownColor: Colors.white,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 24, vertical: 16),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      items: const [
                                        DropdownMenuItem(
                                            value: 'Remove it from my order',
                                            child: CustomText(
                                                content:
                                                    'Remove it from my order',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey)),
                                        DropdownMenuItem(
                                            value: '',
                                            child: CustomText(content: ''))
                                      ],
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: CustomText(
                                          content:
                                              '\$${restaurantAddonBloc.totalPrice(restaurantAddonBloc.turnOn, success.foodItems.quantityFood)}',
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold)),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                        onTap: () {
                                          restaurantAddonBloc.add(
                                              RestaurantAddonNavigateToCartEvent(
                                                  foodItems: success.foodItems,
                                                  restaurant:
                                                      success.restaurant,
                                                  context: context));
                                        },
                                        child: RiveAnimations
                                            .addToCartAnimation()),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
        }
        return const SizedBox();
      },
    );
  }
}
