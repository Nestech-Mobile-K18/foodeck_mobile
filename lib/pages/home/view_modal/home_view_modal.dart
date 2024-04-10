import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/main.dart';
import 'package:template/widgets/map/mapbox_config.dart';

class HomeViewModel {
  Location location = Location();

  Function(String)? onAddressReceived;

  Future<void> updateAddressOnSupabase(String? address) async {
    if (address != null) {
      // Thực hiện truy vấn SELECT để lấy ID từ bảng dữ liệu
      var response = await supabase
          .from('users') // Thay your_table_name bằng tên bảng của bạn
          .select('id');

      // Lấy danh sách các bản ghi từ kết quả truy vấn
      var records = response.toList() as List;
      // Lặp qua danh sách bản ghi và cập nhật dữ liệu cho mỗi bản ghi
      for (var record in records) {
        // Lấy ID từ bản ghi hiện tại
        var userId = record['id'];
        // Tiếp tục với các thao tác cập nhật thông tin sử dụng ID này
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
