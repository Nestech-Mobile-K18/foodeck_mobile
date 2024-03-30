import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/mapbox_config.dart';

class HomeViewModel {
  Location location = Location();

  Function(String)? onAddressReceived;

  final supabase = Supabase.instance.client;

  Future<void> updateAddressOnSupabase(String? address) async {
    if (address != null) {
      var user = supabase.auth.currentUser;
      if (user != null) {
        var userId = user.id;
        await supabase
            .from('users')
            .update({'address': address}).eq('id', userId);
      }
    }
  }

  Future<void> requestPermissionLocation(BuildContext context) async {
    var permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      LocationData? locationData = await location.getLocation();
      if (locationData != null) {
        double latitude = locationData.latitude!;
        double longitude = locationData.longitude!;
        print('Latitude: $latitude, Longitude: $longitude');

        String accessToken = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
        String apiUrl =
            'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken';

        var response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          String? address = data['features'][0]['place_name'];
          updateAddressOnSupabase(address);

          if (onAddressReceived != null) {
            onAddressReceived!(address!);
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Failed to fetch address')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Location is not granted')));
      }
    }
  }
}
