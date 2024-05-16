import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

class CheckOut extends StatefulWidget {
  const CheckOut(
      {super.key,
      required this.subPrice,
      required this.deliveryFee,
      required this.vat,
      required this.coupon,
      required this.totalPrice});

  final int subPrice, deliveryFee, vat, coupon, totalPrice;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  late CameraPosition _initialCameraPosition;
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);
  int currentCard = 0;
  final searchController = TextEditingController();
  final noteController = TextEditingController();
  bool loading = true;
  bool nothing = true;
  bool isCvvFocused = false;
  final offsetToArm = 220.0;

  @override
  void initState() {
    _initialCameraPosition =
        CameraPosition(target: latLngAddress ?? latLng, zoom: 15);
    super.initState();
  }

  _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }

  _addCurrentMarker() async {
    await mapController.addSymbol(
      SymbolOptions(
        geometry: _initialCameraPosition.target,
        iconSize: 0.2,
        iconImage: Assets.currentMarker,
      ),
    );
  }

  Future addOrderToDatabase() async {
    setState(() {
      nothing = !nothing;
    });
    try {
      await supabase.from('order_complete').insert({
        'restaurant_name': sharedPreferences.getString('restaurantName'),
        'sub_price': widget.subPrice,
        'delivery_fee': widget.deliveryFee,
        'vat': widget.vat,
        'coupon': widget.coupon,
        'total_price': widget.totalPrice,
        'date': DateFormat('dd MMM, yyyy').format(DateTime.now()),
        'address': sharedPreferences.getString('address') ??
            sharedPreferences.getString('currentAddress')!,
        'address1': sharedPreferences.getString('address1') ??
            sharedPreferences.getString('currentAddress1')!,
        'note': noteController.text.trim()
      }).then((value) async {
        late dynamic id;
        var response = await supabase.from('order_complete').select('id');
        var records = response.toList() as List;
        for (var record in records) {
          var orderCompleteId = record['id'];
          setState(() {
            id = orderCompleteId;
          });
        }
        for (int index = 0;
            index < CartItemsListData.cartItems.length;
            index++) {
          await supabase.from('orders').insert({
            'food_name': CartItemsListData.cartItems[index].foodItems.nameFood,
            'price': CartItemsListData.cartItems[index].price,
            'quantity': CartItemsListData.cartItems[index].quantity,
            'note': CartItemsListData.cartItems[index].note,
            'order_complete_id': id
          });
        }
      });
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppColor.buttonShadowBlack,
          content: Text(error.message)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: AppColor.buttonShadowBlack,
          content: Text('Error occurred, please retry')));
    }
    CartItemsListData.cartItems.clear();
  }

  @override
  void dispose() {
    searchController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Checkout', fontWeight: FontWeight.bold)),
        body: RefreshIndicator.adaptive(
          onRefresh: () =>
              Future.delayed(const Duration(seconds: 1), () => setState(() {})),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 278,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, top: 24),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(
                                            content: 'Delivery Address',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        CustomWidgets.currentAddress(
                                            sharedPreferences
                                                    .getString('address') ??
                                                sharedPreferences.getString(
                                                    'currentAddress')!,
                                            sharedPreferences
                                                    .getString('address1') ??
                                                sharedPreferences.getString(
                                                    'currentAddress1')!)
                                      ]),
                                  GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => SelectAddress(
                                                textEditingController:
                                                    searchController));
                                      },
                                      child: Image.asset(Assets.pencil))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox(
                                      height: 160,
                                      child: MapboxMap(
                                          zoomGesturesEnabled: false,
                                          scrollGesturesEnabled: false,
                                          rotateGesturesEnabled: false,
                                          dragEnabled: false,
                                          doubleClickZoomEnabled: false,
                                          tiltGesturesEnabled: false,
                                          onMapIdle: _addCurrentMarker,
                                          accessToken:
                                              dotenv.env['MAPBOX_ACCESS_TOKEN'],
                                          initialCameraPosition:
                                              _initialCameraPosition,
                                          onMapCreated: _onMapCreated)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
                      SizedBox(
                        height: 230,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                  content: 'Delivery Instructions',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              const CustomText(
                                  content:
                                      'Let us know if you have specific things in mind',
                                  color: Colors.grey),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: CustomFormFill(
                                  textEditingController: noteController,
                                  hintText: 'e.g. I am home around 10 pm',
                                  hintColor: Colors.grey,
                                  inputColor: Colors.grey,
                                  focusErrorBorderColor: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
                      SizedBox(
                        height: 288,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 24, right: 20, left: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                      content: 'Payment Method',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: SizedBox(
                                height: 210,
                                child: CreditCardWidget(
                                  cardBgColor: AppColor.globalPink,
                                  labelCardHolder: '',
                                  cardType: CardType.mastercard,
                                  enableFloatingCard: true,
                                  isHolderNameVisible: true,
                                  cardNumber: '',
                                  expiryDate: '',
                                  cardHolderName: '',
                                  cvvCode: '',
                                  showBackView: isCvvFocused,
                                  onCreditCardWidgetChange: (p0) {},
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 8,
                        color: AppColor.dividerGrey,
                      ),
                      SizedBox(
                        height: (CartItemsListData.cartItems.length * 80) + 560,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              OrderSummary(
                                  res: CartItemsListData.cartItems,
                                  subPrice: widget.subPrice,
                                  deliveryFee: widget.deliveryFee,
                                  vat: widget.vat,
                                  coupon: widget.coupon),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 34, horizontal: 24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        content: '\$${widget.totalPrice}',
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                    CustomButton(
                                      text: const CustomText(
                                          content: 'Pay Now',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      color: AppColor.globalPink,
                                      heightBox: 54,
                                      widthBox: 172,
                                      paddingLeft: 8,
                                      onPressed: () {
                                        addOrderToDatabase().whenComplete(
                                          () {
                                            setState(() {
                                              loading = !loading;
                                            });
                                          },
                                        ).whenComplete(() => Future.delayed(
                                            const Duration(milliseconds: 1500),
                                            () => Navigator.pushNamed(context,
                                                AppRouter.orderComplete)));
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              nothing
                  ? const SizedBox()
                  : loading
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: SizedBox(
                              height: 100, child: Lottie.asset(Assets.done)))
            ],
          ),
        ),
      ),
    );
  }
}
