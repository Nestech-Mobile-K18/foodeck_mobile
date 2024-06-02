import 'package:flutter/material.dart';
import 'package:template/pages/map/widget/show_map.dart';

class MapBoxView extends StatelessWidget {
  const MapBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Map Direction'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const ShowMap(),
    );
  }
}
