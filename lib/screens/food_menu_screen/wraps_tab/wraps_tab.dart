import 'package:flutter/material.dart';

class WrapsTab extends StatefulWidget {
  const WrapsTab({super.key});

  @override
  State<WrapsTab> createState() => _WrapsTabState();
}

class _WrapsTabState extends State<WrapsTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.orangeAccent,
    );
  }
}
