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
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 200,
                      flexibleSpace: RestaurantAppBar(
                          image: success.foodItems.picture,
                          name: success.foodItems.nameFood,
                          place: success.foodItems.place,
                          restaurant: success.restaurant)),
                  body: SingleChildScrollView(
                    child: SizedBox(
                      height: 1200,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          SizedBox(
                              height: 290,
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
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
                                      height: 200,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: success
                                              .foodItems.availableAddons.length,
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
                                                        color: Colors.grey[300])
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
                            height: 160,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
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
                                                MainAxisAlignment.spaceBetween,
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
                                                                restaurant: success
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
                                                    icon:
                                                        const Icon(Icons.add)),
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
                                height: 190,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 24, bottom: 10),
                                      child: CustomText(
                                          content: 'Extra Sauce',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 110,
                                      width: MediaQuery.of(context).size.width,
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
                                              activeColor: AppColor.globalPink,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              secondary: CustomText(
                                                  content: '+\$${addon.price}',
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
                                                        restaurant:
                                                            success.restaurant,
                                                        foodItems:
                                                            success.foodItems));
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
                            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                                restaurant: success.restaurant,
                                                context: context));
                                      },
                                      child:
                                          RiveAnimations.addToCartAnimation()),
                                )
                              ],
                            ),
                          )
                        ],
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
