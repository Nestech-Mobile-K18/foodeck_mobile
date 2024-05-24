import 'package:flutter/material.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_textfield.dart';
import 'package:template/widgets/method_button.dart';

import '../../../resources/const.dart';
import '../../../services/auth_manager.dart';
import '../../../widgets/custom_text.dart';
import '../vm/food_menu_view_model.dart';

class FoodVariationsView extends StatefulWidget {
  final Map<String, dynamic>? bindingData;

  const FoodVariationsView({super.key, this.bindingData});

  @override
  State<FoodVariationsView> createState() => _FoodVariationsViewState();
}

class _FoodVariationsViewState extends State<FoodVariationsView> {
  final TextEditingController instructionsController = TextEditingController();
  bool isLiked = false;
  final FoodMenuViewModel _viewmodel = FoodMenuViewModel();
  String? selectedVariation;
  List<String> selectedExtraSauce = [];
  int quantity = 1;
  String selectedAction = 'Remove it from my order'; // Default value
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _checkIfLiked();
    _initializeSelectedVariation();
    _calculateTotalPrice(); // Calculate total price initially
  }

  Future<void> _checkIfLiked() async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      final menuIds = await _viewmodel.getListLikeFoodIds(userId);
      setState(() {
        isLiked = menuIds.contains(widget.bindingData?['id_food']);
      });
    }
  }

  Future<void> _toggleLike() async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      if (isLiked) {
        await _viewmodel.requestDeleteLikeFood(
            userId, widget.bindingData?['id_food']);
      } else {
        await _viewmodel.requestUpdateLikeFood(widget.bindingData?['id_food']);
      }
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  void _initializeSelectedVariation() {
    final variations = widget.bindingData?['variation'] as List<dynamic>?;
    if (variations != null && variations.isNotEmpty) {
      selectedVariation = variations.first.keys.first;
      _calculateTotalPrice();
    }
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
        _calculateTotalPrice();
      }
    });
  }

  void _increaseQuantity() {
    setState(() {
      quantity++;
      _calculateTotalPrice();
    });
  }

  void _calculateTotalPrice() {
    final variationList = widget.bindingData?['variation'] as List<dynamic>?;
    final variationMap = variationList != null && variationList.isNotEmpty
        ? variationList.first as Map<String, dynamic>?
        : null;

    final extraSauceList = widget.bindingData?['extra_sauce'] as List<dynamic>?;
    final extraSauceMap = extraSauceList != null && extraSauceList.isNotEmpty
        ? extraSauceList.first as Map<String, dynamic>?
        : null;

    totalPrice = _viewmodel.calculatePrice(
      variationMap: variationMap,
      selectedVariation: selectedVariation,
      extraSauceMap: extraSauceMap,
      selectedExtraSauce: selectedExtraSauce,
      quantity: quantity,
      bindingData: widget.bindingData,
    );
  }



  @override
  Widget build(BuildContext context) {
    final variationList = widget.bindingData?['variation'] as List<dynamic>?;
    final variationMap = variationList != null && variationList.isNotEmpty
        ? variationList.first as Map<String, dynamic>?
        : null;

    final variationKeys = variationMap?.keys.toList() ?? [];

    final extraSauceList = widget.bindingData?['extra_sauce'] as List<dynamic>?;
    final extraSauceMap = extraSauceList != null && extraSauceList.isNotEmpty
        ? extraSauceList.first as Map<String, dynamic>?
        : null;

    final extraSauceKeys = extraSauceMap?.keys.toList() ?? [];

    // Options for the dropdown menu
    final List<String> availabilityActions = [
      'Remove it from my order',
      'Contact me for substitution',
      'Leave it as it is'
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.screenHeight(context) * 0.2),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.bindingData?['image_food']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorsGlobal.globalWhite,
                  ),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: widget.bindingData?['food_name'],
                      size: 22,
                      color: ColorsGlobal.globalWhite,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: Responsive.screenWidth(context) * 0.9,
                      child: CustomText(
                        title: widget.bindingData?['address_restaurant'],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 2,
                        size: 17,
                        color: ColorsGlobal.globalWhite,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 35,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.pink : ColorsGlobal.globalWhite,
                      ),
                      onPressed: _toggleLike,
                    ),
                    const Icon(
                      Icons.share_outlined,
                      color: ColorsGlobal.globalWhite,
                    ),
                    const Icon(
                      Icons.more_vert_outlined,
                      color: ColorsGlobal.globalWhite,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (variationMap != null) ...[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomText(
                      textAlign: TextAlign.start,
                      title: 'Variations',
                      size: 20,
                      color: ColorsGlobal.globalBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: CustomText(
                      title: 'Required',
                      size: 17,
                      color: ColorsGlobal.globalPink,
                    ),
                  )
                ],
              ),
              Column(
                children: variationKeys.map((key) {
                  return ListTile(
                    title: Row(
                      children: [
                        Radio<String>(
                          value: key,
                          groupValue: selectedVariation,
                          onChanged: (String? value) {
                            setState(() {
                              selectedVariation = value;
                              _calculateTotalPrice();
                            });
                          },
                        ),
                        CustomText(
                          title: '$key\'\'',
                          color: ColorsGlobal.globalBlack,
                          size: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    trailing: CustomText(
                      title: "\$${variationMap[key]}",
                      color: ColorsGlobal.globalBlack,
                      size: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
              const CrossBar(
                height: 10,
                color: ColorsGlobal.dividerGrey,
              )
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    title: 'Quantity',
                    size: 20,
                    color: ColorsGlobal.globalBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Responsive.screenWidth(context),
                  decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(16.0)),
                      border: Border.all(
                          color: ColorsGlobal.dividerGrey, width: 2)),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decreaseQuantity,
                      ),
                      Expanded(
                        child: TextField(
                          controller: TextEditingController(
                            text: quantity == 0
                                ? ''
                                : quantity.toString().padLeft(2, '0'),
                          ),
                          textAlign: TextAlign.center,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onEditingComplete: () {
                            setState(() {
                              if (quantity == 0) {
                                quantity = 1;
                              }
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                quantity = 1;
                              } else {
                                quantity = int.tryParse(value) ?? quantity;
                              }
                              _calculateTotalPrice();
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _increaseQuantity,
                      ),
                    ],
                  ),
                ),
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                )
              ],
            ),
            if (extraSauceMap != null) ...[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomText(
                  textAlign: TextAlign.start,
                  title: 'Extra Sauce',
                  size: 20,
                  color: ColorsGlobal.globalBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: extraSauceKeys.map((key) {
                  return ListTile(
                    title: Row(
                      children: [
                        Checkbox(
                          value: selectedExtraSauce.contains(key),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedExtraSauce.add(key);
                                } else {
                                  selectedExtraSauce.remove(key);
                                }
                                _calculateTotalPrice();
                              }
                            });
                          },
                        ),
                        CustomText(
                          title: key,
                          color: ColorsGlobal.globalBlack,
                          size: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    trailing: CustomText(
                      title: "+\$${extraSauceMap[key]}",
                      color: ColorsGlobal.globalBlack,
                      size: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
              const CrossBar(
                height: 10,
                color: ColorsGlobal.dividerGrey,
              )
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    title: 'Instructions',
                    size: 20,
                    color: ColorsGlobal.globalBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    title: 'Let us know if you have specific things in mind',
                    size: 18,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLine: 2,
                    color: ColorsGlobal.textGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomTextField(
                      controller: instructionsController,
                      disableTitle: true,
                      hintText: 'e.g. less spices, no mayo etc',
                    )),
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    title: 'If the product is not available',
                    size: 20,
                    color: ColorsGlobal.globalBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: Responsive.screenHeight(context) * 0.1,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                          border: Border.all(
                              color: ColorsGlobal.dividerGrey, width: 2)),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedAction,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAction = newValue!;
                          });
                        },
                        items: availabilityActions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )),

                // ignore: prefer_const_constructors
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomText(
                    title: '\$${totalPrice.toStringAsFixed(2)}',
                    color: ColorsGlobal.globalBlack,
                    size: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MethodButton(
                  onTap: () {
                    _viewmodel.requestAddToCart(
                      context: context,
                      foodData: widget.bindingData!,
                      extraSauceMap: extraSauceMap,
                      variationMap: variationMap,
                      selectedExtraSauce: selectedExtraSauce,
                      selectedVariation: selectedVariation,
                      quantity: quantity,
                      totalPrice: totalPrice,
                    );
                  },
                  color: ColorsGlobal.globalPink,
                  title: 'Add to cart',
                  widthButton: Responsive.screenWidth(context) * 0.5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
