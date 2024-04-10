import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'mapbox_config.dart';

class ShowMap extends StatelessWidget {
  const ShowMap({super.key});

  ///  This is the Map Display Widget used for MapBoxView
  @override
  Widget build(BuildContext context) {
    // Returns a Flutter Map
    return FlutterMap(
      options: const MapOptions(
        // Configure where the location will display on the map
        // ignore: deprecated_member_use
        center: MapBoxConfig
            .MY_POSITION, // Get the coordinates and longitude through the myPosition variable of the MapBoxConfig class
        minZoom: 5,
        maxZoom: 25,
        // ignore: deprecated_member_use
        zoom: 18,
      ),
      children: [
        // These are the configuration components of MapBox created on the website https://studio.mapbox.com/
        TileLayer(
          // This is the accessToken, you can get it by selecting Studio -> Styles -> select map style -> Share your style -> ThirdParty -> select CARTO format -> copy the Integration URL
          urlTemplate: MapBoxConfig.URL_TEMPLATE,
          additionalOptions: const {
            // This is the Token key of the account that you must provide -> Account -> copy the Default public token link
            'accessToken': MapBoxConfig.MAPBOX_ACCESS_TOKEN,
          },
        ),
        // Maker is the current coordinates the user is displaying on the map. You can customize the properties
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
    );
  }
}
