import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/mapbox_config.dart';
import 'package:template/services/table_supbase.dart';
import '../../../services/auth_manager.dart';

class HomeViewModel extends ChangeNotifier {
  Location location = Location();
  Function(String)? onAddressReceived;
  final supabase = Supabase.instance.client;
  final API _api = API();
  static const String _baseUrl = MapBoxConfig.BASE_URL_MAPBOX;
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
  int _totalQuantity = 0;

  int get totalQuantity => _totalQuantity;

  void updateTotalQuantity(int newQuantity) {
    _totalQuantity = newQuantity;
    notifyListeners();
  }

  Future<Map<String, dynamic>> calculateDistanceAndTime(
      String userAddress, String restaurantAddress) async {
    final userCoordinates = await _getCoordinates(userAddress);
    final restaurantCoordinates = await _getCoordinates(restaurantAddress);
    Map<String, dynamic> result = {};

    if (userCoordinates != null && restaurantCoordinates != null) {
      final distance =
          _calculateDistance(userCoordinates, restaurantCoordinates) / 1000;
      final durationInSeconds =
          await _calculateDuration(userCoordinates, restaurantCoordinates);

      result['distance'] = distance.toStringAsFixed(
          1); // Round the number of kilometers to 1 digit after the decimal point
      result['durationInSeconds'] = durationInSeconds;
    }
    return result;
  }

  Future<List<double>?> _getCoordinates(String address) async {
    final apiUrl =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$address.json?access_token=$_apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'].isNotEmpty) {
        final coordinates = data['features'][0]['geometry']['coordinates'];
        return [coordinates[1], coordinates[0]]; // Return [latitude, longitude]
      }
    }
    return null;
  }

  double _calculateDistance(
      List<double> userCoordinates, List<double> restaurantCoordinates) {
    const earthRadius = 6371e3; // Earth radius in meters
    final lat1 = userCoordinates[0] * (3.141592653589793 / 180);
    final lon1 = userCoordinates[1] * (3.141592653589793 / 180);
    final lat2 = restaurantCoordinates[0] * (3.141592653589793 / 180);
    final lon2 = restaurantCoordinates[1] * (3.141592653589793 / 180);
    final dlat = lat2 - lat1;
    final dlon = lon2 - lon1;

    final a = (sin(dlat / 2) * sin(dlat / 2)) +
        (cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2));
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = earthRadius * c;

    return distance;
  }

  Future<String> _calculateDuration(
      List<double> userCoordinates, List<double> restaurantCoordinates) async {
    final apiUrl =
        'https://api.mapbox.com/directions/v5/mapbox/driving/${userCoordinates[1]},${userCoordinates[0]};${restaurantCoordinates[1]},${restaurantCoordinates[0]}?access_token=$_apiKey';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final durationInSeconds = data['routes'][0]['duration'];
      // Convert durationInSeconds to int
      final intDurationInSeconds = durationInSeconds.toInt();
      // Convert seconds to time string
      final duration = Duration(seconds: intDurationInSeconds);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      return '$hours hour $minutes minutes';
    }
    return '0 seconds';
  }

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

  Future<List<Map<String, dynamic>>?> responseListMenu() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu =
        data.where((item) => item['recommended'] == true).toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }

  Future<List<String>> getListLikeMenuIds(String userId) async {
    final userRecord = await supabase
        .from('users')
        .select('list_like')
        .eq('id', userId)
        .single();

    final dynamic likedMenus = userRecord['list_like'];
    List<String> menuIds = [];

    if (likedMenus != null) {
      if (likedMenus is List<dynamic>) {
        menuIds.addAll(likedMenus.map((item) => item.toString()));
      } else {
        menuIds.add(likedMenus.toString());
      }
    }

    return menuIds;
  }

  Future<void> requestUpdateIsLike(String menuId) async {
    final String? userId = await AuthManager.getUserId();
    if (userId != null) {
      // Get the list of menus that have been liked by the user
      final userRecord = await supabase
          .from('users')
          .select('list_like')
          .eq('id', userId)
          .single();

      // Get the list of liked menus from the query results
      final dynamic likedMenus = userRecord['list_like'];
      List<String> updatedList = [];

      if (likedMenus != null) {
        if (likedMenus is List<dynamic>) {
          // If likedMenus is a List, add all elements to the updatedList
          updatedList.addAll(likedMenus.map((item) => item.toString()));
        } else {
          // If likedMenus is not a List, add it to updatedList
          updatedList.add(likedMenus.toString());
        }

        // If menuId does not exist in the list, add it to the list
        if (!updatedList.contains(menuId)) {
          updatedList.add(menuId);
        }
      } else {
        // If the menu list is null, create a new list and add menuId
        updatedList.add(menuId);
      }

      // Update the list of user's liked menus on the database
      await supabase
          .from('users')
          .update({'list_like': updatedList}).eq('id', userId);
    }
  }

  Future<void> requestDeleteIsLike(String userId, String menuId) async {
    // Get the list of menus that have been liked by the user
    final userRecord = await supabase
        .from('users')
        .select('list_like')
        .eq('id', userId)
        .single();

    // Get the list of liked menus from the query results
    final dynamic likedMenus = userRecord['list_like'];
    List<String> updatedList = [];

    if (likedMenus != null) {
      if (likedMenus is List<dynamic>) {
        // If likedMenus is a List, add all elements to the updatedList
        updatedList.addAll(likedMenus.map((item) => item.toString()));
      } else {
        // If likedMenus is not a List, add it to updatedList
        updatedList.add(likedMenus.toString());
      }

      // Remove menuId from the list
      updatedList.remove(menuId);
    }

    // Check if the list has become empty
    if (updatedList.isEmpty) {
      // If the list is empty, update the list_like column with the value of an empty list
      await supabase.from('users').update({'list_like': []}).eq('id', userId);
    } else {
      // If the list is not empty, update the user's liked menu list on the database
      await supabase
          .from('users')
          .update({'list_like': updatedList}).eq('id', userId);
    }
  }

  Future<void> clearCart() async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      // Clear the cart
      await supabase.from('cart').update({'list_cart': []}).eq('user_id', userId);

      // Update total quantity
      _totalQuantity = 0;
      notifyListeners();
    }
  }

  // Future<int> fetchTotalQuantityFromSupabase() async {
  //   final String? userId = await AuthManager.getUserId();
  //   if (userId != null) {
  //     final response = await supabase
  //         .from('cart')
  //         .select('list_cart')
  //         .eq('user_id', userId)
  //         .single();
  //     if (response != null && response['list_cart'] != null) {
  //       final listCart = response['list_cart'] as List<dynamic>;
  //       int totalQuantity = listCart.fold(0, (sum, item) => sum + (item['quantity'] as int? ?? 0));
  //       return totalQuantity;
  //     }
  //   }
  //   return 0;
  // }
  // Future<int> getTotalQuantityInCart() async {
  //   int totalQuantity = await fetchTotalQuantityFromSupabase();
  //   updateTotalQuantity(totalQuantity);
  //   return totalQuantity;
  // }

}
