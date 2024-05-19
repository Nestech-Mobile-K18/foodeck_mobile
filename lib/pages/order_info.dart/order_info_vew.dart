import 'package:template/pages/export.dart';

class OrderInfoVew extends StatefulWidget {
  const OrderInfoVew({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _OrderInfoVewState createState() => _OrderInfoVewState();
}

class _OrderInfoVewState extends State<OrderInfoVew> {
  late final FoodInfo foodInfo;
  String selectedOptionVariation = '';
  final Set<String> _selectedItem = {};
  final TextEditingController _instructionsController = TextEditingController();
  late final List<FoodStatus> _foodOptions;
  late FoodStatus _selectedOption;
  double _price = 0;
  @override
  void initState() {
    // api get info food
    foodInfo = foodOrderInfo;

    _foodOptions = foodOptions;
    _selectedOption = _foodOptions[0];
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarRestaurant(
            title: foodInfo.name,
            isFavourite: foodInfo.isFavourite,
            address: foodInfo.address,
            imageRestaurant: foodInfo.image!,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.variation,
                        style: AppTextStyle.title,
                      ),
                      Text(
                        AppStrings.required,
                        style: AppTextStyle.textPink,
                      )
                    ],
                  ),
                  ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: foodInfo.type.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            RadioListTile<String>(
                              contentPadding: const EdgeInsets.all(0),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(foodInfo.type[index].typeName),
                                  Text(
                                    '\$${foodInfo.type[index].typePrice.toString()}',
                                    style: AppTextStyle.value,
                                  )
                                ],
                              ),
                              value: foodInfo.type[index].typeId,
                              groupValue: selectedOptionVariation,
                              onChanged: (value) {
                                setState(() {
                                  selectedOptionVariation = value!;
                                });
                              },
                            ),
                            if (index != foodInfo.type.length - 1)
                              const Divider(),
                          ],
                        );
                      }),
                ],
              ),
            ),

            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            // Quanity
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: Text(AppStrings.quanity, style: AppTextStyle.title),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p8,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p24),
              child: InputQty(
                maxVal: 100,
                initVal: 0,
                isIntrinsicWidth: false,
                qtyFormProps:
                    const QtyFormProps(keyboardType: TextInputType.number),
                decoration: QtyDecorationProps(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorsGlobal.grey),
                        borderRadius: BorderRadius.circular(AppRadius.r16)),
                    minusBtn: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p16),
                      child: const Icon(
                        Icons.remove,
                        color: ColorsGlobal.grey,
                        size: 30,
                      ),
                    ),
                    plusBtn: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p16, vertical: AppPadding.p16),
                      child:
                           Icon(Icons.add, color: ColorsGlobal.grey, size: 30.dp),
                    )),
                onQtyChanged: (val) {},
              ),
            ),
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            //Extra Sauce
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p4),
              child: Text(AppStrings.extraSauce, style: AppTextStyle.title),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
              child: ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: foodInfo.extra.length,
                itemBuilder: (_, index) {
                  var title = foodInfo.extra[index].extraName;
                  return ListTile(
                    leading: Checkbox(
                      value: _selectedItem.contains(title),
                      onChanged: (value) {
                        if (value!) {
                          _selectedItem.add(title);
                        } else {
                          _selectedItem.remove(title);
                        }
                        setState(() {
                          print(_selectedItem);
                        });
                      },
                    ),
                    title: Text(
                      title,
                      style: AppTextStyle.label,
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            // Instructions
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.instructions, style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Text(AppStrings.letUsKnow,
                      style: AppTextStyle.decription),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: InputDecoration(
                      hintText: AppStrings.hintTextInstructions,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsGlobal.grey3, // Set border color
                        ),
                        borderRadius:
                            BorderRadius.circular(AppRadius.r16), // Set border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsGlobal.globalPink, // Set border color
                        ),
                        borderRadius:
                            BorderRadius.circular(AppRadius.r16), // Set border radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            // If the product is not available
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.ifProductIsNotAvailabel,
                      style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsGlobal.grey3, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(AppRadius.r16), // Border radius
                    ),
                    child: DropdownButton<FoodStatus>(
                      isExpanded: true,
                      value: _selectedOption,
                      items: _foodOptions.map((FoodStatus option) {
                        return DropdownMenuItem<FoodStatus>(
                          value: option,
                          child: Center(
                            child: Text(option.label),
                          ),
                        );
                      }).toList(),
                      underline: Container(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ],
      ),
      bottomNavigationBar: BottomCheckout(
        label: AppStrings.addToCart,
        price: _price,
        width: AppSize.s137,
      ),
    );
  }
}
