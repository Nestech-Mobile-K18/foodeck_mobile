import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';
import '../../../services/auth_manager.dart';
import '../../../services/mapbox_config.dart';

/// A view model for managing map-related data and interactions.
class MapViewModel extends ChangeNotifier {
  late MapController mapController = MapController();
  final Location _location = Location();
  final supabaseClient = Supabase.instance.client;
  final API _api = API();
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
  static const String _baseUrl = MapBoxConfig.BASE_URL_MAPBOX;
  String currentQuery = '';
  late Timer _debounce = Timer(const Duration(milliseconds: 0), () {});
  List<Map<String, dynamic>> searchResults = [];
  bool _isLoading = false;
  final supabase = Supabase.instance.client;
  bool get isLoading => _isLoading;
  bool isSearching = false;

  /// Retrieves the user's current location.
  Future<LatLng?> setLocationUser() async {
    LocationData? locationData = await _location.getLocation();
    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;
    return LatLng(latitude, longitude);

  }

  /// Retrieves the user's address based on their current location.
  Future<Map<String, String?>?> setAddressUser(
      LatLng? requestAddress, BuildContext context) async {
    try {
      double longitude = requestAddress!.longitude;
      double latitude = requestAddress.latitude;

      String accessToken = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
      String apiUrl =
          '$_baseUrl$longitude,$latitude.json?access_token=$accessToken';

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        var firstFeature = data['features'][0];
        String? address = firstFeature['place_name'];

        String? type = firstFeature['text'];
        await addLocationOnSupabase(address, type, context);
        return {"address": address, "type": type};
      }
    } catch (e) {
      // Handle various error cases, e.g. network errors, unknown errors, etc.
      return null;
    }
    return null;
  }

  Future<void> updateLocationOnSupabase(String? address, String? typeAddress,
      String? addressInstructions, int index) async {
    if (address != null) {
      // Get userId from users table

      final String? userId = await AuthManager.getUserId();

      // Query the location_user table
      var locationResponse = await supabase
          .from('location_user')
          .select('*')
          .eq('user_id', userId!);
      var locations = locationResponse;

      if (locations.isNotEmpty) {
        // Check if index is valid
        if (index >= 0 && index <= 5) {
          int step = index +1;
          var addressColumn = 'address_$step';
          var typeColumn = 'type_address_$step';
          var addressInstructionsColumn = 'address_instructions_$step';

          // Update information at index
          await supabase.from('location_user').update({
            addressColumn: address,
            typeColumn: typeAddress,
            addressInstructionsColumn: addressInstructions
          }).eq('user_id', userId);
        }
      }
    }
  }

  Future<void> addLocationOnSupabase(
      String? address, String? typeAddress, BuildContext context) async {
    if (address != null) {
      // Get userId from users table
      final String? userId = await AuthManager.getUserId();
      // Query the location_user table
      var locationResponse = await supabase
          .from('location_user')
          .select('*')
          .eq('user_id', userId!);
      var locations = locationResponse;

      if (locations.isNotEmpty) {
        // Check address columns 2 to 5
        for (int i = 1; i <= 5; i++) {
          var addressColumn = 'address_$i';
          var typeColumn = 'type_address_$i';
          var addressInstructionsColumn = 'address_instructions_$i';
          var existingAddress = locations[0][addressColumn];

          if (existingAddress == null) {
            // Update data if column is empty
            await supabase.from('location_user').update({
              addressColumn: address,
              typeColumn: typeAddress,
              addressInstructionsColumn: 'Near empty plot'
            }).eq('user_id', userId);
            break; // Exit the loop after updating
          } else if (i == 5 && existingAddress != null) {
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Replace first location?'),
                  content: const Text(
                      'Do you want to replace your first location with this new one?'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // Replace the first location
                        await supabase.from('location_user').update({
                          'address_1': address,
                          'type_address_1': typeAddress,
                          'address_instructions_1': 'Near empty plot'
                        }).eq('user_id', userId);

                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
          }
        }
      } else {
        // Add a new record if it doesn't exist yet
        await supabase.from('location_user').insert({
          'user_id': userId,
          'address_2': address,
          'type_address_2': typeAddress,
          'address_instructions_2': 'Near empty plot'
        });
      }
    }
  }

  Future<void> deleteLocationOnSupabase(String address, String typeAddress,
      String? addressInstructions, BuildContext context) async {
    // Get userId from users table

    final String? userId = await AuthManager.getUserId();

    // Query the location_user table
    var locationResponse = await supabase
        .from('location_user')
        .select('*')
        .eq('user_id', userId!);
    var locations = locationResponse;

    if (locations.isNotEmpty) {
      // Check address columns 2 to 5
      for (int i = 1; i <= 5; i++) {
        var addressColumn = 'address_$i';
        var typeColumn = 'type_address_$i';
        var addressInstructionColumn = 'address_instructions_$i';
        var existingAddress = locations[0][addressColumn];
        var existingType = locations[0][typeColumn];
        var existingAddressInstruction =
            locations[0][addressInstructionColumn];

        if (existingAddress == address &&
            existingType == typeAddress &&
            existingAddressInstruction == addressInstructions) {
          // Delete data if address and address type exist
          await supabase.from('location_user').update({
            addressColumn: null,
            typeColumn: null,
            addressInstructionColumn: null
          }).eq('user_id', userId);

          // Move data from the following columns to the current column
          for (int j = i + 1; j <= 5; j++) {
            var nextAddressColumn = 'address_$j';
            var nextTypeColumn = 'type_address_$j';
            var nextAddressInstructionColumn = 'address_instructions_$j';
            var nextAddress = locations[0][nextAddressColumn];
            var nextType = locations[0][nextTypeColumn];
            var nextAddressInstruction =
                locations[0][nextAddressInstructionColumn];

            // If the following column has data, push the data into the current column and delete the data in the following column
            if (nextAddress != null && nextType != null) {
              await supabase.from('location_user').update({
                addressColumn: nextAddress,
                typeColumn: nextType,
                addressInstructionColumn: nextAddressInstruction,
                nextAddressColumn: null,
                nextTypeColumn: null,
                nextAddressInstructionColumn: null
              }).eq('user_id', userId);
            } else {
              // If the following column has no data, exit the loop
              break;
            }
          }
          break; // Exit the loop after deleting and moving data
        }
      }
    }
    }

  /// Retrieves the user ID from the database.
  Future<String?> responseUserId() async {
    String? getUserId = await AuthManager.getUserId();

    return getUserId;
  }

  // The function after converting the data will be called to dump the data into LocationCard
  Future<List<Map<String, String?>>> convertLocationDataToList() async {
    final String? getUserId = await responseUserId();
    if (getUserId == null) {
      return [];
    }

    var columns = [
      TableSupabase.addressColumn1,
      TableSupabase.type_address_1_Column,
      TableSupabase.address_instructions_1_Column,
      TableSupabase.addressColumn2,
      TableSupabase.type_address_2_Column,
      TableSupabase.address_instructions_2_Column,
      TableSupabase.addressColumn3,
      TableSupabase.type_address_3_Column,
      TableSupabase.address_instructions_3_Column,
      TableSupabase.addressColumn4,
      TableSupabase.type_address_4_Column,
      TableSupabase.address_instructions_4_Column,
      TableSupabase.addressColumn5,
      TableSupabase.type_address_5_Column,
      TableSupabase.address_instructions_5_Column,
    ];

    final addressResponse = await _api.requestSelectedByQuery(
      TableSupabase.localUserTable,
      columns,
      TableSupabase.userIdColumn,
      getUserId,
    );

    // Convert data to a list of items of the form {'type_address': ..., 'address': ..., 'address_instructions' : ...}
    List<Map<String, String?>> result = [];
    for (var locationData in addressResponse) {
      result.addAll(convertLocationDataItemToList(locationData));
    }

    return result
        .where((item) =>
            item['type_address'] != null &&
            item['address'] != null &&
            item['address_instructions'] != null)
        .toList();
  }

  List<Map<String, String?>> convertLocationDataItemToList(
      Map<String, dynamic> locationData) {
    List<Map<String, String?>> result = [];
    int i = 1;
    while (locationData.containsKey('type_address_$i') &&
        locationData.containsKey('address_$i') &&
        locationData.containsKey('address_instructions_$i')) {
      result.add({
        'type_address': locationData['type_address_$i'],
        'address': locationData['address_$i'],
        'address_instructions': locationData['address_instructions_$i']
      });
      i++;
    }
    return result;
  }

  /// Searches for places based on the given query.
  /// assigned to Nam Nguyen
  Future<void> searchPlaces(String query) async {
    try {
      // Set _isLoading to true when starting the search
      _isLoading = true;
      // Notify listeners that _isLoading has changed
      notifyListeners();

      // Cancel debounce timer before starting a new one
      cancelDebounce();

      // Start a new debounce timer
      _debounce = Timer(const Duration(milliseconds: 300), () async {
        currentQuery = query;
        String apiUrl =
            '$_baseUrl${Uri.encodeFull(query)}.json?access_token=$_apiKey';
        var response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          if (data['features'] is List) {
            List<Map<String, dynamic>> results =
                (data['features'] as List).map((feature) {
              String placeName = feature['place_name'];
              String placeType = (feature['place_type'] as List).join(', ');
              return {'place_name': placeName, 'place_type': placeType};
            }).toList();

            searchResults = results;
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception('Failed to search places');
        }
        // Notify listeners after updating searchResults
        notifyListeners();
      });
    } catch (e) {
      if(kDebugMode){
        print(e);
      }
    } finally {
      // Set _isLoading to false when the search is complete
      _isLoading = false;
      // Notify listeners that _isLoading has changed
      notifyListeners();
    }
  }

  /// Cancels the debounce timer.
  void cancelDebounce() {
    if (_debounce.isActive) _debounce.cancel();
  }

  Future<LatLng?> getLocationFromPlaceName(String placeName) async {
    try {
      String apiUrl =
          '$_baseUrl${Uri.encodeFull(placeName)}.json?access_token=$_apiKey';

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var features = data['features'];
        if (features != null && features.isNotEmpty) {
          var firstFeature = features[0];
          var center = firstFeature['center'];
          if (center != null && center.length >= 2) {
            double latitude = center[1];
            double longitude = center[0];
            return LatLng(latitude, longitude);
          }
        }
      }
    } catch (e) {
      if(kDebugMode){
        print('Error fetching location: $e');
      }
    }
    return null;
  }
}
