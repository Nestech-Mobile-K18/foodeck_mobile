import 'package:flutter/material.dart';
import 'package:template/pages/export.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController _instructionsController = TextEditingController();
  late final List<CardPay> _cards;
  late final List<OrderSummary> _orderSummary;

  @override
  void initState() {
    _cards = cards;
    _orderSummary = orderSummary;
    super.initState();
  }

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _handlePay() async {
    Navigator.of(context).pushNamed(RouteName.checkoutWait);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(
        title: 'Checkout',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Address',
                          style: TextStyle(
                              fontSize: 20.dp, fontWeight: FontWeight.w700)),
                      Row(
                        children: [
                          Flexible(
                            child: Text('Block P Phase 1 Johar Town, Lahore',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17.dp, color: Colors.grey)),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 160.dp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.dp),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2.0.dp,
                      ),
                    ),
                    // child: google map
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            // Delivery Instructions
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 8.dp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Instructions',
                      style: TextStyle(
                          fontSize: 20.dp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  Text('Let us know if you have specific things in mind',
                      style: TextStyle(fontSize: 17.dp, color: Colors.grey)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: InputDecoration(
                      hintText: 'e.g. I am home around 10 pm',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade300, // Set border color
                        ),
                        borderRadius:
                            BorderRadius.circular(16.0), // Set border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsGlobal.globalPink, // Set border color
                        ),
                        borderRadius:
                            BorderRadius.circular(16.0), // Set border radius
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
            //Payment Method
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payment Method',
                          style: TextStyle(
                              fontSize: 20.dp, fontWeight: FontWeight.w700)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  ),
                  Container(
                    height: 200.0.dp,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.dp),
                            image: DecorationImage(
                              image: AssetImage(_cards[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 328.0.dp,
                          // height: 150.dp,
                          // padding: EdgeInsets.only(right: 24.dp),
                          margin: EdgeInsets.symmetric(horizontal: 4.0.dp),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            //Order Summary
            Padding(
              padding: EdgeInsets.only(
                  top: 24.dp, right: 24.dp, left: 24.dp, bottom: 8.dp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary',
                      style: TextStyle(
                          fontSize: 20.dp, fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  Text('Let us know if you have specific things in mind',
                      style: TextStyle(fontSize: 17.dp, color: Colors.grey)),
                  SizedBox(
                    height: 5.dp,
                  ),
                  ListView.builder(
                      physics:
                          const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: _orderSummary.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                                trailing: Text(
                                  "\$${_orderSummary[index].price}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 17.dp),
                                ),
                                title: Text(
                                    "${_orderSummary[index].quanity}x ${_orderSummary[index].foodName}",
                                    style: TextStyle(fontSize: 17.dp))),
                          ],
                        );
                      }),
                  ListTile(
                      trailing: Text(
                        "\$100",
                        style: TextStyle(color: Colors.grey, fontSize: 17.dp),
                      ),
                      title:
                          Text("Subtotal", style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      trailing: Text(
                        "\$20",
                        style: TextStyle(color: Colors.grey, fontSize: 17.dp),
                      ),
                      title: Text("Delivery Fee",
                          style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      trailing: Text(
                        "\$4",
                        style: TextStyle(color: Colors.grey, fontSize: 17.dp),
                      ),
                      title: Text("VAT", style: TextStyle(fontSize: 17.dp))),
                  const Divider(),
                  ListTile(
                      trailing: Text(
                        "\$4",
                        style: TextStyle(color: Colors.green, fontSize: 17.dp),
                      ),
                      title: Text("Coupon", style: TextStyle(fontSize: 17.dp)))
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomCheckout(
        label: 'Pay Now',
        price: 20,
        width: 117.dp,
        onPressed: () => _handlePay(),
      ),
    );
  }
}
