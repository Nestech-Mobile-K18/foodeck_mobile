import 'package:flutter/material.dart';
import 'package:foodeck_app/widgets/appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: Header(headerTitle: "Cart"),
      ),
    );
  }
}
