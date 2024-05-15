import 'package:template/source/export.dart';

class DetailFood extends StatefulWidget {
  final FoodItems foodItems;
  final Map<Addon, bool> select = {};
  final DesktopFood desktopFood;

  DetailFood({super.key, required this.foodItems, required this.desktopFood}) {
    for (Addon addon in foodItems.availableAddons) {
      select[addon] = false;
    }
  }

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  RadioType turnOn = RadioType.a;
  late Timer timer;
  final noteController = TextEditingController();

  void addToCart() {
    RiveUtils.changeSMITriggerState(addToCartModel.statusTrigger!);
    FocusManager.instance.primaryFocus?.unfocus();
    List<String> currentSelect = [];
    for (Addon addon in widget.foodItems.availableAddons) {
      if (widget.select[addon] == true) {
        currentSelect.add(addon.addonName);
      }
      if (widget.select[addon] == false) {
        currentSelect.add('');
      }
    }
    List<String> currentSize = [];
    currentSize.add(choseTopping(turnOn, addonItems).elementAt(0).size);
    context.read<Restaurant>().cartItems.add(CartItems(
        note: noteController.text,
        foodItems: widget.foodItems,
        size: currentSize,
        price: totalPrice,
        selectAddon: currentSelect,
        quantity: widget.foodItems.quantityFood));
    Future.delayed(
        const Duration(milliseconds: 3300),
        () => Navigator.pushNamed(context, AppRouter.addCart,
            arguments: AddCart(restaurantName: widget.desktopFood.shopName)));
  }

  void holdPressButtonDecrease() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (widget.foodItems.quantityFood > 1) {
        setState(() {
          widget.foodItems.quantityFood--;
        });
      } else {
        null;
      }
    });
  }

  void holdPressButtonIncrease() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        widget.foodItems.quantityFood++;
      });
    });
  }

  List<Addon> choseTopping(RadioType radioType, List<Addon> full) {
    return full.where((addon) => addon.radio == radioType).toList();
  }

  List<bool> like = [false, false];
  List<int> slot = [0, 0];

  void getAddonPrice(int index) {
    switch (index) {
      case 0:
        like[0] = !like[0];
        like[0] ? slot[0] = addonItems[0].price : slot[0] = 0;
        break;
      case 1:
        like[1] = !like[1];
        like[1] ? slot[1] = addonItems[1].price : slot[1] = 0;
        break;
    }
  }

  int get totalPrice {
    int addonPriceSize = choseTopping(turnOn, addonItems)
        .fold(0, (previousValue, element) => previousValue + element.priceSize);
    return (slot[0] + slot[1] + addonPriceSize) * widget.foodItems.quantityFood;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Consumer<Restaurant>(
          builder: (BuildContext context, Restaurant value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              flexibleSpace: DetailAppBar(
                image: widget.foodItems.picture,
                name: widget.foodItems.nameFood,
                place: widget.foodItems.place,
                desktopFood: widget.desktopFood,
              )),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    content: 'Variation',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                CustomText(
                                  content: 'Required',
                                  color: globalPink,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 200,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.foodItems.availableAddons.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Addon addon =
                                        widget.foodItems.availableAddons[index];
                                    return Column(
                                      children: [
                                        RadioListTile.adaptive(
                                          secondary: CustomText(
                                              content: '\$${addon.priceSize}'),
                                          title:
                                              CustomText(content: addon.size),
                                          activeColor: globalPink,
                                          value: addon.radio,
                                          groupValue: turnOn,
                                          onChanged: (value) {
                                            setState(() {
                                              turnOn = value!;
                                            });
                                          },
                                        ),
                                        addonItems.length - 1 == index
                                            ? const SizedBox()
                                            : Divider(color: Colors.grey[300])
                                      ],
                                    );
                                  })),
                          const Divider(
                            thickness: 8,
                            color: dividerGrey,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 160,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  content: 'Quantity',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 15),
                                child: Container(
                                  height: 54,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTapDown: (details) {
                                          holdPressButtonDecrease();
                                        },
                                        onTapCancel: () {
                                          timer.cancel();
                                        },
                                        child: IconButton(
                                            onPressed: () {
                                              value.removeQuantity(
                                                  widget.foodItems);
                                            },
                                            icon: const Icon(Icons.remove)),
                                      ),
                                      CustomText(
                                          content:
                                              '${widget.foodItems.quantityFood}'
                                                  .padLeft(2, '0')),
                                      GestureDetector(
                                        onTapDown: (details) {
                                          holdPressButtonIncrease();
                                        },
                                        onTapCancel: () {
                                          timer.cancel();
                                        },
                                        child: IconButton(
                                            onPressed: () {
                                              value.addQuantity(
                                                  widget.foodItems);
                                            },
                                            icon: const Icon(Icons.add)),
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
                            color: dividerGrey,
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
                              padding: EdgeInsets.only(left: 24, bottom: 10),
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
                                      widget.foodItems.availableAddons.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    Addon addon =
                                        widget.foodItems.availableAddons[index];
                                    return CheckboxListTile.adaptive(
                                      checkColor: Colors.white,
                                      activeColor: globalPink,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      secondary: CustomText(
                                          content: '+\$${addon.price}',
                                          color: Colors.grey),
                                      title: CustomText(
                                          content: addon.addonName,
                                          color: Colors.grey),
                                      value: widget.select[addon],
                                      onChanged: (bool? valueA) {
                                        setState(() {
                                          widget.select[addon] = valueA!;
                                        });
                                        getAddonPrice(index);
                                      },
                                    );
                                  }),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Divider(
                                thickness: 8,
                                color: dividerGrey,
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
                          padding: const EdgeInsets.only(top: 24, bottom: 15),
                          child: CustomFormFill(
                            textEditingController: noteController,
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
                    color: dividerGrey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 24),
                            child: CustomText(
                                content: 'If the product is not available',
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 60),
                          child: DropdownButtonFormField(
                            iconEnabledColor: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                            hint: CustomText(
                                content: 'Remove it from my order',
                                color: Colors.grey.shade400),
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
                                  value: 'Remove it from my order',
                                  child: CustomText(
                                      content: 'Remove it from my order',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey)),
                              DropdownMenuItem(
                                  value: '', child: CustomText(content: ''))
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
                                content: '\$$totalPrice',
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        CustomWidget.addToCartAnimation(addToCart)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
