import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/mapbox_config.dart';
import 'package:template/services/table_supbase.dart';

import '../../../services/auth_manager.dart';

class HomeViewModel extends ChangeNotifier {
  Location location = Location();
  Function(String)? onAddressReceived;
  final supabase = Supabase.instance.client;
  static const String _baseUrl = MapBoxConfig.BASE_URL_MAPBOX;
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;

  Future<void> updateAddressOnSupabase(
      String? address, String? type_address) async {
    if (address != null) {
      // Perform a SELECT query to get the ID from the data table
      var response = await supabase
          .from('users') // Replace your_table_name with your table name
          .select('id');

      // Get a list of records from query results
      var records = response.toList();
      // Loop through the list of records and update the data for each record
      for (var record in records) {
        // Get the ID from the current record
        var userId = record['id'];
        // Continue with the information update operations using this ID
        if (userId != null) {
          var locationResponse = await supabase
              .from('location_user')
              .select('id_location')
              .eq('user_id', userId);
          if (locationResponse.isEmpty) {
            await supabase.from('location_user').upsert({
              TableSupabase.userIdColumn: userId,
              TableSupabase.addressColumn1: address,
              TableSupabase.type_address_1_Column: type_address,
              TableSupabase.address_instructions_1_Column: 'Near empty plot',
            }).eq('user_id', userId);
          }
        }
      }
    }
  }

  Future<String?> getLocationDataById() async {
    // Get the current user's ID
    final String? userId = await AuthManager.getUserId();
    if (userId == null) {
      return null;
    }

    var locationColumns = [
      'address_1',
      'address_2',
      'address_3',
      'address_4',
      'address_5'
    ];

    // Loop through the location columns to find the first non-null address
    for (var addressColumn in locationColumns) {
      var addressResponse = await supabase
          .from('location_user')
          .select(addressColumn)
          .eq('user_id', userId)
          .single();

      var address = addressResponse[addressColumn];
      if (address != null) {
        return address;
      }
    }
    return null;
  }

  Future<void> requestPermissionLocation(BuildContext context) async {
    var permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      LocationData? locationData = await location.getLocation();
      if (locationData != null) {
        double latitude = locationData.latitude!;
        double longitude = locationData.longitude!;
        print('Latitude: $latitude, Longitude: $longitude');

        String apiUrl =
            '$_baseUrl$longitude,$latitude.json?access_token=$_apiKey';

        var response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          var firstFeature = data['features'][0];
          String? address = firstFeature['place_name'];

          String? type = firstFeature['text'];

          await updateAddressOnSupabase(address, type);

          // Call getLocationDataById to get address
          String? receivedAddress = await getLocationDataById();

          // Pass the received address to onAddressReceived
          if (onAddressReceived != null) {
            onAddressReceived!(receivedAddress!);
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
