import 'package:flutter/material.dart';
import 'package:template/pages/my_orders/views/order_details_view.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/cross_bar.dart';
import 'package:template/widgets/custom_text.dart';
import '../vm/my_orders_view_model.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  late Future<List<Map<String, dynamic>>> _proposedFoodFuture;
  late Future<List<Map<String, dynamic>>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _proposedFoodFuture = MyOrderViewModel().fetchProposedFood();
    _ordersFuture = MyOrderViewModel().fetchOrders();
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _ordersFuture = MyOrderViewModel().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: 'My Orders',
          size: 17,
          fontWeight: FontWeight.w700,
          color: ColorsGlobal.globalBlack,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CrossBar(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    title: 'Recent Order',
                    size: 17,
                    fontWeight: FontWeight.w700,
                    color: ColorsGlobal.globalBlack,
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _proposedFoodFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching proposed food'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No proposed food found'));
                      } else {
                        final proposedFood = snapshot.data!;
                        return SizedBox(
                          height: Responsive.screenHeight(context) * 0.3,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: proposedFood.length,
                            itemBuilder: (context, index) {
                              final foodItem = proposedFood[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        foodItem['image_food'],
                                        fit: BoxFit.cover,
                                        height: Responsive.screenHeight(context) * 0.2,
                                        width: Responsive.screenWidth(context) * 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    CustomText(
                                      title: foodItem['food_name'],
                                      size: 16,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsGlobal.globalBlack,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                      title: '\$${foodItem['price']}',
                                      size: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorsGlobal.globalGrey,
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
            const CrossBar(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _ordersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching proposed food'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No order food found'));
                } else {
                  final orders = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (final order in orders) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: CustomText(
                                title: order['order_name'],
                                size: 17,
                                color: ColorsGlobal.globalBlack,
                                fontWeight: FontWeight.w400,
                              ),
                              subtitle: Text(order['created_at']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    title: '\$${order['information_order']['checkout_data']['totalPrice']}',
                                    color: ColorsGlobal.globalGrey,
                                    size: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final result = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OrderDetailsView(orderDetailData: order),
                                        ),
                                      );
                                      if (result == true) {
                                        // If the return result is correct, update the order list
                                        _refreshOrders();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorsGlobal.globalShadowBlack,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
