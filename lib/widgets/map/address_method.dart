import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:template/main.dart';
import 'package:template/values/images.dart';
import 'package:template/widgets/map/dio_exception.dart';

Dio _dio = Dio();
String navType = 'cycling';

Future getCyclingRouteUsingMapbox(LatLng source, LatLng destination) async {
  String url =
      'https://api.mapbox.com/directions/v5/mapbox/$navType/${source.longitude},${source.latitude};${destination.longitude},${destination.latitude}?alternatives=true&continue_straight=true&geometries=geojson&language=en&overview=full&steps=true&access_token=${dotenv.env['MAPBOX_ACCESS_TOKEN']}';
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage =
        DioExceptions.fromDioError(e as DioException).toString();
    debugPrint(errorMessage);
  }
}

LatLng getLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

LatLng getAddress() {
  return LatLng(
      sharedPreferences.getDouble('latitudeAddress') ??
          sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitudeAddress') ??
          sharedPreferences.getDouble('longitude')!);
}

late MapboxMapController mapController;
List responses = [];
LatLng? latLngAddress = getAddress();
LatLng latLng = getLatLngFromSharedPrefs();

Future<Map> getDirectionsAPIResponse(
    LatLng currentLatLng, LatLng endPoint) async {
  final response = await getCyclingRouteUsingMapbox(currentLatLng, endPoint);
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];
  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}

Future moveCamera(index) async {
  await mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: responses[index]['location'], zoom: 15)));
  await mapController.addSymbol(
    SymbolOptions(
      geometry: responses[index]['location'],
      iconSize: 2,
      iconImage: Assets.marker,
    ),
  );
}
