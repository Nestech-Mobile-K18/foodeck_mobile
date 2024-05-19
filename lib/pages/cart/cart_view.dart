import 'package:template/pages/export.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final List<Food> _cart;
  late final List<Item> _popularFood;
  late final double total;
  late final double fee;
  late final double vat;
  late final double coupon;
  late final double subTotal;
  @override
  void initState() {
    _cart = cart;
    _popularFood = popularFood;
    fee = getFee();
    vat = getVAT();
    coupon = getCoupon();
    subTotal = getSubTotal(cart);
    total = getTotal(subTotal, fee, vat, coupon);

    super.initState();
  }

  double getFee() {
    //hard code
    return 10;
  }

  double getSubTotal(List<Food> cart) {
    return cart.fold(0, (double subTotal, Food obj) => subTotal + obj.price);
  }

  double getVAT() {
    //hard code
    return 4;
  }

  double getCoupon() {
    //hard code
    return 4;
  }

  double getTotal(double subTotal, double fee, double vat, double coupon) {
    return subTotal + fee + vat - coupon;
  }

  Future<void> _handleCheckout() async {
    // create list order summary
    List<OrderSummary> orderSummary = cart.map((item) {
      return OrderSummary(item.foodName, item.price, item.quanity);
    }).toList();

    // Navigator.of(context).pushNamed(RouteName.checkout);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CheckoutView(
                coupon: coupon,
                fee: fee,
                orderSummary: orderSummary,
                total: total,
                vat: vat,
              ),
          settings: const RouteSettings(name: RouteName.checkout)),
    );
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
          title: AppStrings.titleCart, ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
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
                        horizontal: AppPadding.p24, vertical: AppPadding.p12),
                    child: Text(
                      AppStrings.popularWithThese,
                      style: AppTextStyle.titleSmall,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: AppPadding.p24),
                    height: AppSize.s250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _popularFood.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: AppSize.s250,
                            padding: EdgeInsets.only(right: AppPadding.p24),
                            margin:
                                EdgeInsets.symmetric(horizontal: AppMargin.m4),
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
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.titleCoupon,
                    style: AppTextStyle.title,
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r16),
                      border: Border.all(
                        color: ColorsGlobal.grey3,
                        width: AppSize.s22,
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
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.subtotal,
                        style: AppTextStyle.title,
                      ),
                      Text(
                        '\$$subTotal',
                        style: AppTextStyle.textPinkBold,
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.deliveryFee,
                        style: AppTextStyle.label,
                      ),
                      Text(
                        '\$$fee',
                        style: AppTextStyle.value,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.vat,
                        style: AppTextStyle.label,
                      ),
                      Text(
                        '\$$vat',
                        style: AppTextStyle.value,
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.coupon,
                        style: AppTextStyle.label,
                      ),
                      Text(
                        '-\$$coupon',
                        style: AppTextStyle.textGreen,
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
        label: AppStrings.goToCheckout,
        price: total,
        width: AppSize.s172,
        onPressed: () => _handleCheckout(),
      ),
    );
  }
}
