import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';
import '../../../services/mapbox_config.dart';

class MapViewModel extends ChangeNotifier {
  late MapController mapController = MapController();
  final Location _location = Location();
  final supabaseClient = Supabase.instance.client;
  final API _api = API();
  static const String _apiKey = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
  static const String _baseUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
  String currentQuery = '';
  late Timer _debounce = Timer(Duration(milliseconds: 0), () {});
  List<Map<String, dynamic>> searchResults = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool isSearching = false;

  Future<void> targetUserLocation() async {
    LocationData? locationData = await _location.getLocation();
    if (locationData != null) {
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      mapController.move(
        LatLng(latitude, longitude),
        18,
      );
    }
  }

  Future<LatLng?> setLocationUser() async {
    LocationData? locationData = await _location.getLocation();
    if (locationData != null) {
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;
      return LatLng(latitude, longitude);
    }
    return null;
  }

  Future<Map<String, String?>?> setAddressUser() async {
    try {
      LatLng? requestAddress = await setLocationUser();
      double longitude = requestAddress!.longitude;
      double latitude = requestAddress.latitude;

      String accessToken = MapBoxConfig.MAPBOX_ACCESS_TOKEN;
      String apiUrl =
          'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$accessToken';

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        var firstFeature = data['features'][0];
        String? address = firstFeature['place_name'];

        String? type = firstFeature['text'];

        return {"address": address, "type": type};
      }
    } catch (e) {
      // Handle various error cases, e.g. network errors, unknown errors, etc.
      print('Error fetching address: $e');
      return null;
    }
  }

  Future<String?> responseUserId() async {
    String? getUserId;
    var res = await _api.requestSelected(
        TableSupabase.usersTable, TableSupabase.idColumn);

    var records = res?.toList();
    if (records != null && records.isNotEmpty) {
      var record = records.first;
      getUserId = record['id'].toString();
    }
    return getUserId;
  }

  Future<List<Map<String, dynamic>>> responseLocation() async {
    final String? getUserId = await responseUserId();
    if (getUserId == null) {
      return [];
    }

    var columns = [
      TableSupabase.addressColumn1,
      TableSupabase.type_address_1_Column
    ];

    final addressResponse = await _api.requestSelectedByQuery(
        TableSupabase.localUserTable,
        columns,
        TableSupabase.userIdColumn,
        getUserId);

    return addressResponse;
  }

  Future<void> searchPlaces(String query) async {
    // Hủy bỏ timer debounce trước khi tạo mới
    if (_debounce.isActive) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 2000), () async {
      currentQuery = query;

      isSearching = true;

      _isLoading = true;
      notifyListeners();

      try {
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

              return {
                'place_name': placeName,
                'place_type': placeType,
              };
            }).toList();

            searchResults = results;
            notifyListeners();
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception('Failed to search places');
        }
      } catch (e) {
        print(e);
      } finally {
        _isLoading = false;
        isSearching = false;
        notifyListeners();
      }
    });
  }

  void cancelDebounce() {
    if (_debounce.isActive) _debounce.cancel();
  }
}
