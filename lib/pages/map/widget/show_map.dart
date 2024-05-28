import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/pages/map/vm/map_view_model.dart';
import 'package:template/pages/map/widget/location_card.dart';
import 'package:template/resources/const.dart';
import 'package:template/widgets/custom_text.dart';

import '../../../services/mapbox_config.dart';

/// Widget for displaying the map and user location.
class ShowMap extends StatefulWidget {
  final MapController? mapController;
  final bool? isShowLocationCard;
  final LatLng? onMarkerSelected;
  final LatLng? onTarget;

  final Function(Map<String, String?>, int)?
      onLongPressLocationCard; // Update the callback type

  const ShowMap(
      {super.key,
      this.mapController,
      this.isShowLocationCard,
      this.onTarget,
      this.onLongPressLocationCard, // Update the parameter type
      this.onMarkerSelected});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  final MapViewModel _vm = MapViewModel();
  late Future<LatLng?> _userLocation;
  late Future<List<Map<String, String?>>> _locationData;
  late Timer _pollingTimer;
  late List<Map<String, String?>> _previousLocationData;

  @override
  void initState() {
    super.initState();
    _userLocation = _vm.setLocationUser();
    _locationData = _vm
        .convertLocationDataToList(); // _locationData retrieves data from the convertLocationDataToList function to retrieve all addresses to display on LocationCard
    _previousLocationData = []; // Initialize the previous data as an empty list
    _startLocationDataPolling();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void _startLocationDataPolling() {
    const pollingInterval = Duration(seconds: 20);
    _pollingTimer = Timer.periodic(pollingInterval, (Timer timer) {
      _fetchLocationData(); // Call the fetch data function every 20 seconds
    });
  }

  Future<void> _fetchLocationData() async {
    final List<Map<String, String?>> newData =
        await _vm.convertLocationDataToList();
    if (!listEquals(_previousLocationData, newData)) {
      // Compare new data and previous data
      setState(() {
        _locationData = Future.value(newData); // Updating data
        _previousLocationData = newData; // Store the latest data
      });
    }
  }

  @override
  void didUpdateWidget(covariant ShowMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onMarkerSelected != oldWidget.onMarkerSelected) {
      // If the marker receives a new LatLng, the camera will point to the marker with the new position
      _moveCameraToSelectedMarker();
    }
  }

  // The camera handler function runs to the marker
  void _moveCameraToSelectedMarker() {
    if (widget.onMarkerSelected != null) {
      widget.mapController?.move(widget.onMarkerSelected!, 18);
    }
  }

  @override
  void dispose() {
    if (_pollingTimer.isActive) {
      _pollingTimer.cancel(); // Cancel the polling Timer action
    }

    super.dispose();
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (widget.onMarkerSelected == null) {
                  _moveCameraToSelectedMarker();
                }
              });
              return FlutterMap(
                mapController: widget.mapController,
                options: MapOptions(
                  center: widget.onMarkerSelected ?? snapshot.data!,
                  //Pass onMarkerSelected to set the center camera location on the map in AddLocation or get the available location in LocationCard
                  minZoom: 5,
                  maxZoom: 25,
                  zoom: 18,
                  onTap: widget.isShowLocationCard == false
                      ? (tapPosition, point) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const CustomText(
                                  title: StringExtensions.addLocation,
                                  color: ColorsGlobal.globalBlack,
                                  size: 20,
                                ),
                                content: const CustomText(
                                  title: StringExtensions.areYouSure,
                                  color: ColorsGlobal.globalBlack,
                                  size: 17,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      _vm.setAddressUser(point, context);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const CustomText(
                                      title: StringExtensions.oke,
                                      color: ColorsGlobal.globalBlack,
                                      size: 17,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const CustomText(
                                      title: StringExtensions.cancel,
                                      color: ColorsGlobal.globalBlack,
                                      size: 17,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      : null,
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
                        point: widget.onMarkerSelected ?? snapshot.data!,
                        //Pass onMarkerSelected to set the maker location on the map in AddLocation or get the available location in LocationCard
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
          top: 350,
          right: 25,
          child: FloatingActionButton(
            onPressed: () async {
              LatLng? userLocation = await _userLocation;
              if (userLocation != null) {
                // Do something with userLocation, e.g., move the map to user's location
                widget.mapController?.move(userLocation, 18);
              }
              if (widget.onTarget != null) {
                widget.mapController?.move(widget.onTarget!, 18);
              }
            },
            tooltip: 'Target User Location',
            backgroundColor: ColorsGlobal.globalPink,
            shape: const CircleBorder(),
            child: const Icon(Icons.my_location_sharp,
                color: ColorsGlobal.globalWhite),
          ),
        ),
        if (widget.isShowLocationCard == true)
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: FutureBuilder<List<Map<String, String?>>>(
              future: _locationData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return LocationCard(
                    locationData: snapshot.data,
                    onItemSelected: (int index) async {
                      LatLng? newLocation = await _vm.getLocationFromPlaceName(
                          snapshot.data![index]['address']!);
                      setState(() {
                        _userLocation = Future<LatLng?>.value(newLocation);
                      });
                    },
                    onLongPress: (int index) {
                      if (widget.onLongPressLocationCard != null) {
                        if (index >= 0 && index < snapshot.data!.length) {
                          widget.onLongPressLocationCard!(
                              snapshot.data![index], index);
                        } // Pass data of selected item
                      }
                    },
                  );
                }
              },
            ),
          ),
      ],
    );
  }
}
