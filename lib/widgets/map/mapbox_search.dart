import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:template/main.dart';
import 'package:template/widgets/map/dio_exception.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
String searchType =
    'country%2Cregion%2Cpostcode%2Cdistrict%2Cplace%2Clocality%2Cneighborhood%2Caddress%2Cpoi';
String searchResultsLimit = '6';
String proximity =
    '${sharedPreferences.getDouble('longitude')}%2C${sharedPreferences.getDouble('latitude')}';
String country = 'vn';

Dio _dio = Dio();

Future getSearchResultsFromQueryUsingMapbox(String query) async {
  String url =
      '$baseUrl/$query.json?country=$country&limit=$searchResultsLimit&proximity=$proximity&types=$searchType&access_token=$accessToken';
  url = Uri.parse(url).toString();

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
