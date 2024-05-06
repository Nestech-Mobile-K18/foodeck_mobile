import 'package:template/pages/export.dart';

class CartVew extends StatefulWidget {
  const CartVew({Key? key}) : super(key: key);

  @override
  _CartVewState createState() => _CartVewState();
}

class _CartVewState extends State<CartVew> {
  late final List<Food> _cart;
  late final List<Item> _popularFood;

  @override
  void initState() {
    _cart = cart;
    _popularFood = popularFood;
    super.initState();
  }

  Future<void> _handleCheckout() async {
    Navigator.of(context).pushNamed(RouteName.checkout);
  }

  Future<void> _handleRestaurant(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RestaurantView(id: id),
          settings: RouteSettings(name: RouteName.restaurant, arguments: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(
        title: 'Cart',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 12.dp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // list food
            ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _cart.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      _cart[index],
                      if (index != _cart.length - 1) const Divider(),
                    ],
                  );
                }),
            // Popular with these
            Container(
              color: ColorsGlobal.grey3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.dp, vertical: 12.dp),
                    child: Text(
                      'Popular with these',
                      style: TextStyle(
                          fontSize: 17.dp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 24.dp),
                    height: 250.0.dp,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularFood.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: 250.0.dp,
                            padding: EdgeInsets.only(right: 24.dp),
                            margin: EdgeInsets.symmetric(horizontal: 4.0.dp),
                            child: InkWell(
                                onTap: () =>
                                    _handleRestaurant(_popularFood[index].id),
                                child: _popularFood[index]));
                      },
                    ),
                  ),
                ],
              ),
            ),
            //Coupon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Coupon',
                    style:
                        TextStyle(fontSize: 20.dp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12.dp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.dp),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2.0.dp,
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Text('GREENLOGIX'),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_forward))
                        ]),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 8.dp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: TextStyle(
                            fontSize: 20.dp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\$50',
                        style: TextStyle(
                            fontSize: 17.dp,
                            color: ColorsGlobal.globalPink,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.dp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '\$10',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'VAT',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '\$4',
                        style: TextStyle(fontSize: 17, color: Colors.grey),
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Coupon',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text(
                        '-\$4',
                        style: TextStyle(fontSize: 17, color: Colors.green),
                      )
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomCheckout(
        label: 'Go to Checkout',
        price: 20,
        width: 172.dp,
        onPressed: () => _handleCheckout(),
      ),
    );
  }
}
