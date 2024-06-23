import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/src/pages/export.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {Key? key,
      required this.orderSummary,
      required this.total,
      required this.fee,
      required this.vat,
      required this.coupon})
      : super(key: key);
  final List<OrderSummary> orderSummary;
  final double total;
  final double fee;
  final double vat;
  final double coupon;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _instructionsController = TextEditingController();
  late final List<CardPay> _cards;
  late final List<OrderSummary> _orderSummary;
  late final CoordinatesData _coordinatesData;
  @override
  void initState() {
    _cards = cards;
    _orderSummary = orderSummary;

    _coordinatesData = coordinatesData;
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
        title: AppStrings.checkout,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.deliveryAddress,
                          style: AppTextStyle.title),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(_coordinatesData.address!,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.decription),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: AppSize.s160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r16),
                      border: Border.all(
                        color: ColorsGlobal.grey3,
                        // width: AppSize.s22,
                      ),
                    ),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(
                            _coordinatesData.lat!, _coordinatesData.lng!),
                        initialZoom: 19,
                        minZoom: 0,
                        maxZoom: 19,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName:
                              'net.tlserver6y.flutter_map_location_marker.example',
                          maxZoom: 19,
                        ),
                        CurrentLocationLayer(
                          followOnLocationUpdate: FollowOnLocationUpdate.always,
                          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => launchUrl(Uri.parse(
                                  'https://openstreetmap.org/copyright')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            // Delivery Instructions
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
                  Text(AppStrings.deliveryInstructions,
                      style: AppTextStyle.title),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  Text(AppStrings.letUsKnow, style: AppTextStyle.decription),
                  SizedBox(
                    height: AppSize.s5,
                  ),
                  TextFormField(
                    controller: _instructionsController,
                    decoration: InputDecoration(
                      hintText: AppStrings.hintTextInstruction,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsGlobal.grey3, // Set border color
                        ),
                        borderRadius: BorderRadius.circular(
                            AppRadius.r16), // Set border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: ColorsGlobal.globalPink, // Set border color
                        ),
                        borderRadius: BorderRadius.circular(
                            AppRadius.r16), // Set border radius
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
            //Payment Method
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p24, vertical: AppPadding.p12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.paymentMethod, style: AppTextStyle.title),
                      IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _cards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppRadius.r16),
                            image: DecorationImage(
                              image: AssetImage(_cards[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: AppSize.s328,
                          margin:
                              EdgeInsets.symmetric(horizontal: AppMargin.m4),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorsGlobal.grey3,
              thickness: AppSize.s8,
            ),
            //Order Summary
            Padding(
              padding: EdgeInsets.only(
                  top: AppPadding.p24,
                  right: AppPadding.p24,
                  left: AppPadding.p24,
                  bottom: AppPadding.p8),
              child: OrderSummaryWidget(
                orderSummary: _orderSummary,
                coupon: billDetail.coupon!,
                fee: billDetail.fee!,
                subTotal: billDetail.subTotal,
                vat: billDetail.vat!,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomCheckout(
        label: AppStrings.payNow,
        price: widget.total,
        width: AppSize.s117,
        onPressed: () => _handlePay(),
      ),
    );
  }
}
