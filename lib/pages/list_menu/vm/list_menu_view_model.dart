import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';
import 'package:http/http.dart' as http;

import '../../../services/auth_manager.dart';
import '../../../services/mapbox_config.dart';

class ListMenuViewModel extends ChangeNotifier {
  final API _api = API();
  final supabase = Supabase.instance.client;
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;

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

      result['distance'] = distance.toStringAsFixed(1);
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

      final intDurationInSeconds = durationInSeconds.toInt();

      final duration = Duration(seconds: intDurationInSeconds);
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      return '$hours hour $minutes minutes';
    }
    return '0 seconds';
  }

  Future<List<Map<String, dynamic>>?> responseListMenu() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    return List<Map<String, dynamic>>.from(data);
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
}