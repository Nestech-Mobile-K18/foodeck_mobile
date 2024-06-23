import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:template/main.dart';
import 'package:template/src/features/restaurant/data/model.dart';

class RestaurantService {
  // login with email
  Future<List<RestaurantInfo>?> getRestaurants(RestaurantRequest request) async {
    try {
      List<Map<String, dynamic>> data =
          // await supabase.from('restaurant').select('id, id_address, address(id)');
          await supabase
              .from('restaurant')
              .select('*, address(*)').limit(request.size!);

      List<RestaurantInfo> restaurantList = mapResponseToRestaurantList(data);

      // print('dis ${(Geolocator.distanceBetween(10.7521609, 106.6708993, 10.7523772, 106.664099)/1000).toStringAsFixed(2)}');
      return restaurantList;
    } catch (error) {
      print(error);
      return [];
    }
  }


  Future<List<CalMoveTime>?> getCalMoveTime() async {
    try {
      List<Map<String, dynamic>> data =
          // await supabase.from('restaurant').select('id, id_address, address(id)');
          await supabase
              .from('cal_move_time')
              .select();

      List<CalMoveTime> calMoveTime = mapResponseToCalMoveTimeList(data);

      return calMoveTime;
    } catch (error) {
      print(error);
      return [];
    }
  }
}
