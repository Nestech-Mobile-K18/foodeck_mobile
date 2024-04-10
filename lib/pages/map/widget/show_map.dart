import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:template/pages/map/vm/map_view_model.dart';
import 'package:template/pages/map/widget/location_card.dart';
import 'package:template/resources/colors.dart';

import '../../../services/mapbox_config.dart';

class ShowMap extends StatefulWidget {
  final VoidCallback? onTap;
  final MapController? mapController;
  final bool? isShowLocationCard;
  const ShowMap(
      {Key? key, this.onTap, this.mapController, this.isShowLocationCard})
      : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  final MapViewModel _vm = MapViewModel();
  late Future<LatLng?> _userLocation;

  @override
  void initState() {
    super.initState();
    _userLocation = _vm.setLocationUser();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<LatLng?>(
          future: _userLocation,
          builder: (context, AsyncSnapshot<LatLng?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(); // Placeholder widget while loading
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text('Error or null data: ${snapshot.error}');
            } else {
              return FlutterMap(
                mapController: widget.mapController,
                options: MapOptions(
                  center: snapshot.data!,
                  minZoom: 5,
                  maxZoom: 25,
                  zoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate: MapBoxConfig.URL_TEMPLATE,
                    additionalOptions: const {
                      'accessToken': MapBoxConfig.MAPBOX_ACCESS_TOKEN,
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: snapshot.data!,
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: ColorsGlobal.globalRed,
                          size: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
        Positioned(
          bottom: 200,
          right: 25,
          child: FloatingActionButton(
            onPressed: widget.onTap,
            tooltip: 'Target User Location',
            backgroundColor: ColorsGlobal.globalPink,
            shape: const CircleBorder(),
            child: const Icon(Icons.my_location_sharp,
                color: ColorsGlobal.globalWhite),
          ),
        ),
        if (widget.isShowLocationCard == true)
          Positioned(
            bottom: 20, // Adjust according to your UI needs
            left: 0,
            right: 0,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _vm
                  .responseLocation(), // This should now return a list of locations
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  // Use the length of data for itemCount
                  return LocationCard(
                    onLongPress: () {},
                    itemCount: snapshot.data!
                        .length, // Set itemCount to the number of locations
                    nameOfPlace: snapshot.data![0]
                        ["type_address_1"], // Example for the first location
                    address: snapshot.data![0]
                        ["address_1"], // Example for the first location
                  );
                } else {
                  return const Text('No data');
                }
              },
            ),
          ),
      ],
    );
  }
}
