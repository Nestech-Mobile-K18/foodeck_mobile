import 'package:flutter/material.dart';
import 'package:template/pages/map/widget/show_map.dart';
import 'package:template/resources/colors.dart';

class MapBoxView extends StatelessWidget {
  const MapBoxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('My Locations (3)'),
      ),
      body: const ShowMap(),
    );
  }
}
