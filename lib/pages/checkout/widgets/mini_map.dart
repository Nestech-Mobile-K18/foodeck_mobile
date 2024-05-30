import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/pages/checkout/vm/checkout_view_model.dart';
import '../../../services/mapbox_config.dart';

class MiniMap extends StatefulWidget {
  final String? address;

  const MiniMap({super.key, this.address});

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  late MapController mapController;
  late Future<LatLng> _initialPosition;
  final CheckOutViewModel _viewModel = CheckOutViewModel();

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _initialPosition = _viewModel.getLatLngFromAddress(widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<LatLng>(
        future: _initialPosition,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No location data');
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              mapController.move(snapshot.data!, 15);
            });
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: snapshot.data,
                  zoom: 15,
                  minZoom: 5,
                  maxZoom: 25,
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
                        width: 80,
                        height: 80,
                        point: snapshot.data!,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
