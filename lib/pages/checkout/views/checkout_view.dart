import 'package:flutter/material.dart';
import 'package:template/pages/checkout/vm/checkout_view_model.dart';
import 'package:template/pages/checkout/widgets/mini_map.dart';
import 'package:template/pages/map/views/map_view.dart';
import 'package:template/widgets/method_button.dart';
import '../../../resources/const.dart';
import '../../../widgets/cross_bar.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../cart/models/cart_item.dart';
import '../../payment/views/payment_input_view.dart';
import '../../thank_you/views/thank_you_view.dart';

class CheckoutView extends StatefulWidget {
  final Map<String, dynamic>? checkoutData;

  const CheckoutView({super.key, this.checkoutData});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final CheckOutViewModel _viewModel = CheckOutViewModel();
  String? address;
  final TextEditingController instructionsController = TextEditingController();
  Map<String, dynamic>? _selectedPaymentMethod;

  @override
  void dispose() {
    _viewModel.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsGlobal.globalWhite,
        title: const CustomText(
          title: 'Checkout',
          color: ColorsGlobal.globalBlack,
          size: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: _viewModel.userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          address = snapshot.data!['address'] as String?;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            title: 'Delivery Address',
                            size: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsGlobal.globalBlack,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MapBoxView()));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: ColorsGlobal.globalBlack,
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        fit: FlexFit.loose,
                        child: CustomText(
                          title: address,
                          size: 18,
                          softWrap: true,
                          maxLine: 2,
                          color: ColorsGlobal.textGrey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MiniMap(address: address),
                    ],
                  ),
                ),
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CustomText(
                        textAlign: TextAlign.start,
                        title: 'Delivery Instructions',
                        size: 20,
                        color: ColorsGlobal.globalBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CustomText(
                        textAlign: TextAlign.start,
                        title:
                            'Let us know if you have specific things in mind',
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
                        hintText: 'e.g. I am home around 10 pm',
                      ),
                    ),
                  ],
                ),
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            title: 'Payment Method',
                            size: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsGlobal.globalBlack,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentInputView(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: ColorsGlobal.globalBlack,
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: _viewModel.paymentMethodsStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    title:
                                        "You haven't added any payment method yet.",
                                    size: 18,
                                    color: ColorsGlobal.globalBlack,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PaymentInputView(),
                                        ),
                                      );
                                    },
                                    child: const CustomText(
                                      title: "Add new payment method",
                                      size: 15,
                                      color: ColorsGlobal.globalBlue,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            final paymentMethods = snapshot.data!;
                            // Initialize _selectedPaymentMethod if it's null
                            if (_selectedPaymentMethod == null &&
                                paymentMethods.isNotEmpty) {
                              _selectedPaymentMethod = paymentMethods.first;
                            }
                            return SizedBox(
                              height: 300,
                              child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: paymentMethods.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    _selectedPaymentMethod =
                                        paymentMethods[index];
                                  });
                                },
                                itemBuilder: (context, index) {
                                  final method = paymentMethods[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.asset(MediaRes.creditCard,
                                            fit: BoxFit.cover,
                                            width: Responsive.screenWidth(
                                                context)),
                                        Positioned(
                                          top: 50,
                                          right: 35,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                title: '.... ' +
                                                    method['card_number']
                                                        .substring(15),
                                                color: ColorsGlobal.globalWhite,
                                                size: 25,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 80,
                                              ),
                                              method['payment_method'] == 'Visa'
                                                  ? Image.asset(
                                                      MediaRes.visaCard,
                                                      fit: BoxFit.cover,
                                                      height: 50,
                                                      width: 50,
                                                    )
                                                  : Image.asset(
                                                      MediaRes.masterCard,
                                                      fit: BoxFit.cover,
                                                      height: 50,
                                                      width: 50,
                                                    )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 170,
                                          left: 25,
                                          child: CustomText(
                                            title: method['card_name'],
                                            color: ColorsGlobal.globalWhite,
                                            size: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const CrossBar(
                  height: 10,
                  color: ColorsGlobal.dividerGrey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      const CustomText(
                        title: 'Order Summary',
                        size: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsGlobal.globalBlack,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            widget.checkoutData?['cartItems']?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cartItem = widget.checkoutData?['cartItems']
                              ?[index] as CartItem?;
                          return Column(
                            children: [
                              ListTile(
                                title: CustomText(
                                  title:
                                      '${cartItem?.quantity} x ${cartItem?.foodName}',
                                  size: 17,
                                  color: ColorsGlobal.globalBlack,
                                ),
                                trailing: CustomText(
                                  title: '\$${cartItem?.price ?? 0}',
                                  size: 17,
                                ),
                              ),
                              const CrossBar(height: 2)
                            ],
                          );
                        },
                      ),
                      ListTile(
                        title: const CustomText(
                          title: 'Subtotal',
                          size: 17,
                          color: ColorsGlobal.globalBlack,
                        ),
                        trailing: CustomText(
                          title: '\$${widget.checkoutData?['subtotal'] ?? 0}',
                          size: 17,
                        ),
                      ),
                      const CrossBar(height: 2),
                      ListTile(
                        title: const CustomText(
                          title: 'Delivery Fee',
                          size: 17,
                          color: ColorsGlobal.globalBlack,
                        ),
                        trailing: CustomText(
                          title:
                              '\$${widget.checkoutData?['deliveryFee'] ?? 0}',
                          size: 17,
                        ),
                      ),
                      const CrossBar(height: 2),
                      ListTile(
                        title: const CustomText(
                          title: 'VAT',
                          size: 17,
                          color: ColorsGlobal.globalBlack,
                        ),
                        trailing: CustomText(
                          title:
                              '\$${widget.checkoutData?['vat'].toStringAsFixed(0) ?? 0}',
                          size: 17,
                        ),
                      ),
                      const CrossBar(height: 2),
                      ListTile(
                        title: const CustomText(
                          title: 'Coupon',
                          size: 17,
                          color: ColorsGlobal.globalBlack,
                        ),
                        trailing: CustomText(
                          title:
                              '-\$${widget.checkoutData?['couponValue'].toStringAsFixed(0) ?? 0}',
                          size: 17,
                          color: ColorsGlobal.globalGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: '\$${widget.checkoutData?['totalPrice'] ?? 0}',
                        size: 28,
                        color: ColorsGlobal.globalBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      MethodButton(
                        color: ColorsGlobal.globalPink,
                        title: 'Pay Now',
                        widthButton: Responsive.screenWidth(context) * 0.5,
                        onTap: () {
                          final checkoutData = widget.checkoutData;
                          final address = snapshot.data!['address'] as String?;
                          final instructions = instructionsController.text;

                          if (checkoutData != null &&
                              address != null &&
                              _selectedPaymentMethod != null) {
                            _viewModel.addOrder(checkoutData, address,
                                instructions, _selectedPaymentMethod!);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ThankYouView(
                                      addressUser: address,
                                    )));
                          } else {
                            return;
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
