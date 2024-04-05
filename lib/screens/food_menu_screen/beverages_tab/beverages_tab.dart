import 'package:flutter/material.dart';

class BeveragesTab extends StatefulWidget {
  const BeveragesTab({super.key});

  @override
  State<BeveragesTab> createState() => _BeveragesTabState();
}

class _BeveragesTabState extends State<BeveragesTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
    );
  }
}
