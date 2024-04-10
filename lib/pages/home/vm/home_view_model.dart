import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/widgets/loading_indicator.dart';

import '../../../services/mapbox_config.dart';

class HomeViewModel {
  Location location = Location();

  Function(String)? onAddressReceived;

  final supabase = Supabase.instance.client;

  Future<void> updateAddressOnSupabase(String? address) async {
    if (address != null) {
      // Perform a SELECT query to get the ID from the data table
      var response = await supabase
          .from('users') // Replace your_table_name with your table name
          .select('id');

      // Get a list of records from query results
      var records = response.toList() as List;
      // Loop through the list of records and update the data for each record
      for (var record in records) {
        // Get the ID from the current record
        var userId = record['id'];
        // Continue with the information update operations using this ID
        var updateResponse = await supabase
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
