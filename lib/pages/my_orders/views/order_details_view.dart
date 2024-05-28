import 'package:flutter/material.dart';
import 'package:template/resources/export.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_text.dart';
import 'package:template/widgets/method_button.dart';

import '../../../resources/responsive.dart';
import '../vm/my_orders_view_model.dart';

class OrderDetailsView extends StatefulWidget {
  final Map<String, dynamic>? orderDetailData;

  const OrderDetailsView({super.key, this.orderDetailData});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final MyOrderViewModel _orderViewModel = MyOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          title: widget.orderDetailData?['order_name'],
          color: ColorsGlobal.globalBlack,
          maxLine: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          size: 17,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              title: widget.orderDetailData?['created_at'],
              color: ColorsGlobal.textGrey,
              size: 13,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CrossBar(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: CustomText(
                    title: 'Order Summary',
                    color: ColorsGlobal.globalBlack,
                    size: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget
                          .orderDetailData?['information_order']
                              ['checkout_data']['cartItems']
                          .length ??
                      0,
                  itemBuilder: (context, index) {
                    final foodItem =
                        widget.orderDetailData?['information_order']
                            ['checkout_data']['cartItems'][index];
                    final foodName = foodItem['food_name'] ?? '';
                    final quantity = foodItem['quantity'] ?? '';
                    final price = foodItem['price'] ?? '';
                    return Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              CustomText(
                                title: '$quantity x ',
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              CustomText(
                                title: foodName,
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          trailing: CustomText(
                            title: '\$${price.toStringAsFixed(0)}',
                            color: ColorsGlobal.globalBlack,
                            size: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const CrossBar(height: 2),
                      ],
                    );
                  },
                ),
                ListTile(
                  title: const CustomText(
                    title: 'Subtotal',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                  trailing: CustomText(
                    title:
                        '\$${widget.orderDetailData?['information_order']['checkout_data']['subtotal'].toStringAsFixed(0)}',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                ),
                const CrossBar(height: 2),
                ListTile(
                  title: const CustomText(
                    title: 'Delivery Fee',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                  trailing: CustomText(
                    title:
                        '\$${widget.orderDetailData?['information_order']['checkout_data']['deliveryFee'].toStringAsFixed(0)}',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                ),
                const CrossBar(height: 2),
                ListTile(
                  title: const CustomText(
                    title: 'VAT',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                  trailing: CustomText(
                    title:
                        '\$${widget.orderDetailData?['information_order']['checkout_data']['vat'].toStringAsFixed(0)}',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                ),
                const CrossBar(height: 2),
                ListTile(
                  title: CustomText(
                    title:
                        'Coupon (${widget.orderDetailData?['information_order']['checkout_data']['selectedCouponCode']})',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                  trailing: CustomText(
                    title:
                        '\$${widget.orderDetailData?['information_order']['checkout_data']['couponValue'].toString()}',
                    color: ColorsGlobal.globalBlack,
                    size: 17,
                  ),
                ),
              ],
            ),
            const CrossBar(height: 10),
            Container(
              width: Responsive.screenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Delivery Address',
                    color: ColorsGlobal.globalBlack,
                    size: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    title: widget.orderDetailData?['information_order']
                        ['address'],
                    color: ColorsGlobal.textGrey,
                    size: 17,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLine: 2,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
            const CrossBar(height: 10),
            Container(
              width: Responsive.screenWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Delivery Instructions',
                    color: ColorsGlobal.globalBlack,
                    size: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    title: widget.orderDetailData?['information_order']
                        ['instructions'],
                    color: ColorsGlobal.textGrey,
                    size: 17,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLine: 2,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
            const CrossBar(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Payment Method',
                    color: ColorsGlobal.globalBlack,
                    size: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Image.asset(MediaRes.creditCard,
                          fit: BoxFit.cover,
                          width: Responsive.screenWidth(context)),
                      Positioned(
                        top: 50,
                        right: 35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              title: widget.orderDetailData?[
                                              'information_order']
                                          ['payment_method']['card_number'] !=
                                      null
                                  ? '.... ' +
                                      widget
                                          .orderDetailData!['information_order']
                                              ['payment_method']['card_number']
                                          .substring(15)
                                  : '',
                              // Check if card_number exists before accessing
                              color: ColorsGlobal.globalWhite,
                              size: 25,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            widget.orderDetailData?['information_order']
                                        ['payment_method']['payment_method'] ==
                                    'Visa'
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
                          title: widget.orderDetailData?['information_order']
                                      ['payment_method']['card_number'] !=
                                  null
                              ? widget.orderDetailData!['information_order']
                                  ['payment_method']['card_name']
                              : '',
                          color: ColorsGlobal.globalWhite,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MethodButton(
              color: ColorsGlobal.globalPink,
              title: 'Cancel Order',
              onTap: () async {
                await _orderViewModel.deleteOrder(widget
                    .orderDetailData?['id_order']);
                Navigator.of(context).pop(true);
              },
              widthButton: Responsive.screenWidth(context) * 0.8,
            )
          ],
        ),
      ),
    );
  }
}
