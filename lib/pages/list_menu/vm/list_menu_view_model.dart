import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';
import 'package:http/http.dart' as http;

import '../../../services/mapbox_config.dart';

class ListMenuViewModel extends ChangeNotifier {
  final API _api = API();
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
      final seconds = duration.inSeconds.remainder(60);
      return '$hours hour $minutes minutes';
    }
    return '0 seconds';
  }

  Future<List<Map<String, dynamic>>?> responseListMenu() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    return List<Map<String, dynamic>>.from(data);
  }
}
