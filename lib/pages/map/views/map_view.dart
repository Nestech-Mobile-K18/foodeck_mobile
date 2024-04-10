import 'package:flutter/material.dart';
import 'package:template/pages/map/models/location_model.dart';
import 'package:template/pages/map/views/add_location_view.dart';
import 'package:template/pages/map/vm/map_view_model.dart';

import 'package:template/pages/map/widget/show_map.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

class MapBoxView extends StatefulWidget {
  const MapBoxView({Key? key});

  @override
  State<MapBoxView> createState() => _MapBoxViewState();
}

class _MapBoxViewState extends State<MapBoxView> {
  final MapViewModel _viewModel = MapViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: StringExtensions.myLocations,
              size: 17,
              fontWeight: FontWeight.w700,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddLocationView()));
              },
              child: CustomText(
                title: StringExtensions.add,
                color: ColorsGlobal.globalPink,
                size: 13,
              ),
            )
          ],
        ),
      ),
      body: ShowMap(
        mapController: _viewModel.mapController,
        onTap: _viewModel.targetUserLocation,
        isShowLocationCard: true,
      ),
    );
  }
}
