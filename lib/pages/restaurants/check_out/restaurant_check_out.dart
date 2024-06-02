import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

part 'restaurant_check_out_extension.dart';

class RestaurantCheckOut extends StatefulWidget {
  const RestaurantCheckOut({super.key});

  @override
  State<RestaurantCheckOut> createState() => _RestaurantCheckOutState();
}

class _RestaurantCheckOutState extends State<RestaurantCheckOut> {
  @override
  void initState() {
    context
        .read<RestaurantCheckOutBloc>()
        .add(const RestaurantCheckOutInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantCartBloc = context.read<RestaurantCartBloc>();
    final restaurantCheckOutBloc = context.read<RestaurantCheckOutBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Checkout', fontWeight: FontWeight.bold)),
        body: Stack(
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
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 24),
                        child: Column(
                          children: [
                            ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomText(
                                          content: 'Delivery Address',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      BlocBuilder<RestaurantCheckOutBloc,
                                          RestaurantCheckOutState>(
                                        builder: (context, state) {
                                          switch (state.runtimeType) {
                                            case RestaurantCheckOutLoadedState:
                                              final success = state
                                                  as RestaurantCheckOutLoadedState;
                                              return CustomText(
                                                  content: success.address);
                                          }
                                          return const SizedBox();
                                        },
                                      )
                                    ]),
                                trailing: GestureDetector(
                                    onTap: () {
                                      restaurantCheckOutBloc.searchController
                                          .clear();
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              const SelectAddress());
                                    },
                                    child: Image.asset(Assets.pencil))),
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
                                        onMapIdle: restaurantCheckOutBloc
                                            .addCurrentMarker,
                                        accessToken:
                                            dotenv.env['MAPBOX_ACCESS_TOKEN'],
                                        initialCameraPosition:
                                            restaurantCheckOutBloc
                                                .initialCameraPosition,
                                        onMapCreated: restaurantCheckOutBloc
                                            .onMapCreated)),
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
                                textOverflow: TextOverflow.visible,
                                color: Colors.grey),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: CustomFormFill(
                                textEditingController:
                                    restaurantCheckOutBloc.noteController,
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
                      height: 320,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 24, right: 20, left: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: CreditCard(
                              cardName: '',
                              cardNumber: '',
                              cardType: CardType.master,
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
                      height: (CartItemsListData.cartItems.length * 80) + 500,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            OrderSummary(
                                res: CartItemsListData.cartItems,
                                subPrice: restaurantCartBloc.totalPrice,
                                deliveryFee: restaurantCartBloc.deliveryFee,
                                vat: restaurantCartBloc.vat,
                                coupon: restaurantCartBloc.coupon),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 34, horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      content: '\$${restaurantCartBloc.bill}',
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
                                      restaurantCheckOutBloc.add(
                                          RestaurantCheckOutNavigateToOrderCompleteEvent(
                                              context: context));
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
            BlocBuilder<RestaurantCheckOutBloc, RestaurantCheckOutState>(
              builder: (context, state) {
                switch (state.runtimeType) {
                  case RestaurantCheckOutLoadedState:
                    final success = state as RestaurantCheckOutLoadedState;
                    return success.nothing
                        ? const SizedBox()
                        : success.loading
                            ? const Center(child: CircularProgressIndicator())
                            : Center(
                                child: SizedBox(
                                    height: 100,
                                    child: Lottie.asset(Assets.done)));
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
