import 'package:flutter/cupertino.dart';
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
            imageRestaurant: foodInfo.image,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Variation',
                        style: TextStyle(
                            fontSize: 20.dp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Required',
                        style: TextStyle(
                            fontSize: 17.dp,
                            color: ColorsGlobal.globalPink),
                      )
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
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
                                    style:
                                        const TextStyle(color: Colors.grey),
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
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            // Quanity
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 8.dp),
              child: Text('Quanity',
                  style: TextStyle(
                      fontSize: 20.dp, fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 8.dp, right: 24.dp, left: 24.dp, bottom: 24.dp),
              child: InputQty(
                maxVal: 100,
                initVal: 0,
                isIntrinsicWidth: false,
                qtyFormProps:
                    const QtyFormProps(keyboardType: TextInputType.number),
                decoration: QtyDecorationProps(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16)),
                    minusBtn: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Icon(
                        Icons.remove,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    plusBtn: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Icon(Icons.add, color: Colors.grey, size: 30),
                    )),
                onQtyChanged: (val) {},
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            //Extra Sauce
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 4.dp),
              child: Text('Extra Sauce',
                  style: TextStyle(
                      fontSize: 20.dp, fontWeight: FontWeight.w700)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
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
                    title: Text(title),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            // Instructions
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 8.dp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instructions',
                      style: TextStyle(
                          fontSize: 20.dp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  Text('Let us know if you have specific things in mind',
                      style:
                          TextStyle(fontSize: 17.dp, color: Colors.grey)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: InputDecoration(
                      hintText: 'e.g. less spices, no mayo etc',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300, // Set border color
                        ),
                        borderRadius: BorderRadius.circular(
                            16.0), // Set border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color:
                              ColorsGlobal.globalPink, // Set border color
                        ),
                        borderRadius: BorderRadius.circular(
                            16.0), // Set border radius
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            // If the product is not available
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 8.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('If the product is not available',
                      style: TextStyle(
                          fontSize: 20.dp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 12.dp,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(16.0), // Border radius
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
        label: 'Add to cart',
        price: _price,
        width: 137.dp,
      ),
    );
  }
}
