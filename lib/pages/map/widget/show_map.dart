import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:template/resources/colors.dart';

import '../../../services/mapbox_config.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({Key? key}) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController, // Pass mapController here
          options: MapOptions(
            center: MapBoxConfig.MY_POSITION,
            minZoom: 5,
            maxZoom: 25,
            zoom: 18,
          ),
          children: [
            TileLayer(
              urlTemplate: MapBoxConfig.URL_TEMPLATE,
              additionalOptions: {
                'accessToken': MapBoxConfig.MAPBOX_ACCESS_TOKEN,
              },
            ),
            const MarkerLayer(markers: [
              Marker(
                  point: MapBoxConfig.MY_POSITION,
                  child: Icon(
                    Icons.person_pin,
                    color: Colors.blueAccent,
                    size: 40,
                  ))
            ])
          ],
        ),
        Positioned(
          bottom: 150,
          right: 25,
          child: FloatingActionButton(
            onPressed: () {
              _targetUserLocation();
            },
            tooltip: 'Target User Location',
            backgroundColor: ColorsGlobal.globalPink,
            shape: CircleBorder(),
            child:
                Icon(Icons.my_location_sharp, color: ColorsGlobal.globalWhite),
          ),
        ),
      ],
    );
  }

  void _targetUserLocation() async {
    var location = Location();
    LocationData? locationData = await location.getLocation();
    if (locationData != null) {
      _mapController.move(
        LatLng(locationData.latitude!, locationData.longitude!),
        18,
      );
    }
  }
}
