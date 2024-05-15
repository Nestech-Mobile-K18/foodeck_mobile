import 'package:template/source/export.dart';

class AddCart extends StatefulWidget {
  const AddCart({super.key, required this.restaurantName});

  final String restaurantName;

  @override
  State<AddCart> createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.99);

  int currentCard = 0;
  int deliveryFee = 10;
  int vat = 4;
  int coupon = 4;

  int get totalPrice {
    int addonPrice = context
        .read<Restaurant>()
        .cartItems
        .fold(0, (previousValue, element) => previousValue + element.price);
    return addonPrice;
  }

  int get bill {
    int getBill = totalPrice + deliveryFee + vat - coupon;
    return getBill;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (BuildContext context, Restaurant value, Widget? child) =>
            Scaffold(
              appBar: AppBar(
                  shape: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 8, color: dividerGrey)),
                  title: const CustomText(
                      content: 'Cart', fontWeight: FontWeight.bold)),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 220,
                        child: ListView.builder(
                          itemCount: value.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Badge(
                                          largeSize: 20,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          backgroundColor: Colors.black,
                                          label: CustomText(
                                              content:
                                                  '${value.cartItems[index].quantity}',
                                              fontSize: 12),
                                          child: Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                      image: AssetImage(value
                                                          .cartItems[index]
                                                          .foodItems
                                                          .picture),
                                                      fit: BoxFit.cover))),
                                        ),
                                        RichText(
                                            text: TextSpan(
                                                text:
                                                    '${value.cartItems[index].foodItems.nameFood}\n',
                                                style: AppText.inter.copyWith(
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      '${value.cartItems[index].size[0]} ',
                                                  style: AppText.inter.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.grey)),
                                              WidgetSpan(
                                                  baseline:
                                                      TextBaseline.ideographic,
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .baseline,
                                                  child: Container(
                                                    height: 5,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.grey),
                                                  )),
                                              TextSpan(
                                                  text:
                                                      ' ${value.cartItems[index].selectAddon[0]}\n${value.cartItems[index].selectAddon[1]}\n${value.cartItems[index].note}\n',
                                                  style: AppText.inter.copyWith(
                                                      fontSize: 15,
                                                      color: Colors.grey)),
                                              const WidgetSpan(
                                                  child: SizedBox(
                                                height: 30,
                                              )),
                                              TextSpan(
                                                  text:
                                                      '\$${value.cartItems[index].price}',
                                                  style: AppText.inter.copyWith(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ])),
                                        IconButton(
                                            onPressed: () {
                                              if (value.cartItems.length == 1) {
                                                value.removeFromList(
                                                    value.cartItems[index]);
                                                Navigator.pop(context);
                                              } else {
                                                value.removeFromList(
                                                    value.cartItems[index]);
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.highlight_remove,
                                                color: Colors.grey))
                                      ]),
                                  Divider(color: Colors.grey[300])
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 300,
                        width: double.maxFinite,
                        decoration: const BoxDecoration(color: dividerGrey),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(24, 24, 0, 12),
                                child: CustomText(
                                    content: 'Popular with these',
                                    fontWeight: FontWeight.bold)),
                            Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: SizedBox(
                                    width: 270,
                                    height: 220,
                                    child: Consumer<Restaurant>(
                                      builder: (BuildContext context,
                                          Restaurant drink, Widget? child) {
                                        return PageView.builder(
                                            scrollBehavior:
                                                const ScrollBehavior(),
                                            onPageChanged: (value) {
                                              currentCard = value;
                                            },
                                            controller: pageController,
                                            clipBehavior: Clip.none,
                                            itemCount: drink
                                                .filterCategory(
                                                    FoodCategory.Beverages,
                                                    foodItems)
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index) => BannerItems(
                                                voteStar: const SizedBox(),
                                                paddingImage:
                                                    const EdgeInsets.only(
                                                        right: 10),
                                                paddingText: const EdgeInsets.only(
                                                    left: 3),
                                                foodImage: drink
                                                    .filterCategory(
                                                        FoodCategory.Beverages,
                                                        foodItems)[index]
                                                    .picture,
                                                deliveryTime:
                                                    '\$${drink.filterCategory(FoodCategory.Beverages, foodItems)[index].price}',
                                                shopName: drink
                                                    .filterCategory(
                                                        FoodCategory.Beverages,
                                                        foodItems)[index]
                                                    .nameFood,
                                                shopAddress: drink
                                                    .filterCategory(
                                                        FoodCategory.Beverages,
                                                        foodItems)[index]
                                                    .place,
                                                rateStar: ''));
                                      },
                                    )))
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(24, 24, 0, 16),
                          child: CustomText(
                              content: 'Coupon',
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                        child: DropdownButtonFormField(
                          icon: const Icon(Icons.arrow_forward),
                          borderRadius: BorderRadius.circular(20),
                          hint: const CustomText(content: 'GREELOGIX'),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400),
                                  borderRadius: BorderRadius.circular(16)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          items: const [
                            DropdownMenuItem(
                                value: 'GREELOGIX',
                                child: CustomText(content: 'GREELOGIX')),
                            DropdownMenuItem(
                                value: '', child: CustomText(content: ''))
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: dividerGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    content: 'Subtotal',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                CustomText(
                                    content: '\$$totalPrice',
                                    fontWeight: FontWeight.bold,
                                    color: globalPink)
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'Delivery Fee'),
                                  CustomText(content: '\$$deliveryFee')
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'VAT'),
                                  CustomText(content: '\$$vat')
                                ],
                              ),
                            ),
                            Divider(color: Colors.grey[300]),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(content: 'Coupon'),
                                  CustomText(
                                      content: '-\$$coupon',
                                      color: Colors.green)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                content: '\$$bill',
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                            CustomButton(
                              text: const CustomText(
                                  content: 'Go to Checkout',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              color: globalPink,
                              heightBox: 54,
                              widthBox: 172,
                              paddingLeft: 8,
                              onPressed: () {
                                Navigator.pushNamed(context, AppRouter.checkOut,
                                    arguments: CheckOut(
                                        subPrice: totalPrice,
                                        deliveryFee: deliveryFee,
                                        vat: vat,
                                        coupon: coupon,
                                        totalPrice: bill,
                                        restaurantName: widget.restaurantName));
                              },
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
}
