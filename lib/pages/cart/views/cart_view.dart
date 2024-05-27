import 'package:flutter/material.dart';
import 'package:template/pages/cart/vm/cart_view_model.dart';
import 'package:template/pages/food_menu/views/food_variations_view.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/method_button.dart';
import '../../../resources/const.dart';
import '../../../widgets/corner_clipper.dart';
import '../../../widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../../checkout/views/checkout_view.dart';
import '../widgets/coupon_bottom_sheet.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartViewModel _viewModel;
  static const double deliveryFee = 10.0;
  static const double vat = 4.0;

  @override
  void initState() {
    super.initState();
    _viewModel = CartViewModel();
    _viewModel.requestShowListCart();
    _viewModel.getProposedFoods();
    _viewModel.getCoupon();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsGlobal.globalWhite,
          title: const CustomText(
            title: 'Cart',
            color: ColorsGlobal.globalBlack,
            size: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CrossBar(height: 5),
              Consumer<CartViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.cartItems.isEmpty) {
                    return const Center(
                        heightFactor: 10,
                        child: Text('There are no items in the cart'));
                  } else {
                    final cartItems = viewModel.cartItems;

                    return Container(
                      height: Responsive.screenHeight(context) * 0.5,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return ListTile(
                            title: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipPath(
                                      clipper: CornerClipper(),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          item.imageFood ?? '',
                                          width:
                                          Responsive.screenWidth(context) *
                                              0.2,
                                          height:
                                          Responsive.screenHeight(context) *
                                              0.08,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: -10,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: ColorsGlobal.globalBlack,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorsGlobal.globalBlack,
                                              blurRadius: 50,
                                            ),
                                          ],
                                        ),
                                        child: CustomText(
                                          title: item.quantity.toString(),
                                          size: 18,
                                          color: ColorsGlobal.globalWhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        title: item.foodName,
                                        size: 17,
                                        color: ColorsGlobal.globalBlack,
                                      ),
                                      if (item.variation != null)
                                        CustomText(
                                            title: '${item.variation}\'\''),
                                      if (item.extraSauce != null)
                                        CustomText(
                                            title:
                                            '${item.extraSauce?.join(', ')}'),
                                      CustomText(title: '\$${item.price}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                viewModel.removeItemFromCart(item.idFood ?? '');
                              },
                              icon: const Icon(Icons.cancel,
                                  color: ColorsGlobal.textGrey),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              Container(
                width: Responsive.screenWidth(context),
                padding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                color: ColorsGlobal.dividerGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      title: 'Popular with these',
                      size: 17,
                      color: ColorsGlobal.globalBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: Responsive.screenHeight(context) * 0.2,
                      child: Consumer<CartViewModel>(
                        builder: (context, viewModel, child) {
                          final proposedFoods = viewModel.proposedFoods;
                          if (proposedFoods.isEmpty) {
                            return const Center(
                                child: Text('There are no recommended dishes'));
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: proposedFoods.length,
                              itemBuilder: (context, index) {
                                final item = proposedFoods[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push
                                      (MaterialPageRoute(builder: (context)
                                    =>FoodVariationsView(bindingData: item.toJson(),
                                    )));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Image.network(
                                                item.imageFood ?? '',
                                                width: Responsive.screenWidth(
                                                    context) *
                                                    0.5,
                                                height: Responsive.screenHeight(
                                                    context) *
                                                    0.15,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 10,
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: Responsive.screenWidth(
                                                    context) *
                                                    0.1,
                                                padding:
                                                const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                  color:
                                                  ColorsGlobal.globalWhite,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(8)),
                                                ),
                                                child: CustomText(
                                                  title:
                                                  '\$${item.price.toString()}',
                                                  size: 14,
                                                  color:
                                                  ColorsGlobal.globalBlack,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        CustomText(
                                          title: item.foodName,
                                          size: 17,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsGlobal.globalBlack,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Thêm điều kiện hiển thị cho Column này
              Consumer<CartViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.cartItems.isEmpty) {
                    return Container(); // Ẩn Column nếu cartItems rỗng
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: Responsive.screenWidth(context),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          color: ColorsGlobal.globalWhite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                title: 'Coupon',
                                size: 17,
                                color: ColorsGlobal.globalBlack,
                                fontWeight: FontWeight.bold,
                              ),
                              Consumer<CartViewModel>(
                                builder: (context, viewModel, child) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(16)),
                                      border:
                                      Border.all(color: ColorsGlobal.textGrey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          viewModel.selectedCouponCode ??
                                              'No discount code selected',
                                          style: const TextStyle(
                                            color: ColorsGlobal.globalBlack,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) => CouponBottomSheet(
                                                  cartViewModel: viewModel),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: ColorsGlobal.globalBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const CrossBar(height: 5),
                        Column(
                          children: [
                            ListTile(
                              title: const CustomText(
                                title: 'Subtotal',
                                color: ColorsGlobal.globalBlack,
                                size: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              trailing: Consumer<CartViewModel>(
                                builder: (context, viewModel, child) {
                                  return CustomText(
                                    title:
                                    '\$${viewModel.getTotalPrice().toStringAsFixed(0)}',
                                    color: ColorsGlobal.globalPink,
                                    size: 20,
                                    fontWeight: FontWeight.bold,
                                  );
                                },
                              ),
                            ),
                            ListTile(
                              title: const CustomText(
                                title: 'Delivery Fee',
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: Consumer<CartViewModel>(
                                builder: (context, viewModel, child) {
                                  return CustomText(
                                    title: '\$${deliveryFee.toStringAsFixed(0)}',
                                    color: ColorsGlobal.textGrey,
                                    size: 17,
                                    fontWeight: FontWeight.w400,
                                  );
                                },
                              ),
                            ),
                            const CrossBar(height: 2),
                            ListTile(
                              title: const CustomText(
                                title: 'VAT',
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: Consumer<CartViewModel>(
                                builder: (context, viewModel, child) {
                                  return CustomText(
                                    title: '\$${vat.toStringAsFixed(0)}',
                                    color: ColorsGlobal.textGrey,
                                    size: 17,
                                    fontWeight: FontWeight.w400,
                                  );
                                },
                              ),
                            ),
                            const CrossBar(height: 2),
                            ListTile(
                              title: const CustomText(
                                title: 'Coupon',
                                color: ColorsGlobal.globalBlack,
                                size: 17,
                                fontWeight: FontWeight.w400,
                              ),
                              trailing: Consumer<CartViewModel>(
                                builder: (context, viewModel, child) {
                                  return CustomText(
                                    title:
                                    '-\$${viewModel.selectedCouponValue?.toStringAsFixed(0) ?? '0'}',
                                    color: ColorsGlobal.globalGreen,
                                    size: 17,
                                    fontWeight: FontWeight.w400,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Consumer<CartViewModel>(
                                    builder: (context, viewModel, child) {
                                      final totalPrice =
                                          viewModel.getDiscountedTotalPrice() +
                                              deliveryFee +
                                              vat;
                                      return CustomText(
                                        title: '\$${totalPrice.toStringAsFixed(0)}',
                                        color: ColorsGlobal.globalBlack,
                                        size: 28,
                                        fontWeight: FontWeight.bold,
                                      );
                                    },
                                  ),
                                  MethodButton(
                                      onTap: () {
                                        final totalPrice = _viewModel.getDiscountedTotalPrice() + deliveryFee + vat;
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => CheckoutView(checkoutData: {
                                              'cartItems': _viewModel.cartItems,
                                              'subtotal': _viewModel.getTotalPrice(),
                                              'deliveryFee': deliveryFee,
                                              'vat': vat,
                                              'selectedCouponCode': _viewModel
                                                  .selectedCouponCode ?? '',
                                              'couponValue': _viewModel
                                                  .selectedCouponValue ?? 0,
                                              'totalPrice': totalPrice.toStringAsFixed(0),
                                            },)));
                                      },
                                      color: ColorsGlobal.globalPink,
                                      title: 'Go'
                                          ' to Checkout',
                                      widthButton:
                                      Responsive.screenWidth(context) * 0.5),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
