import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';

class FoodMenuViewModel extends ChangeNotifier {
  final API _api = API();
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>?> responseMenuPopular(
      String? category) async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu = data
        .where((item) =>
            item['type_categories'] == 'Popular' &&
            item['category'] == category)
        .toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }

  Future<List<Map<String, dynamic>>?> responseMenuDeals() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu =
        data.where((item) => item['type_categories'] == 'Deals').toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }

  Future<List<Map<String, dynamic>>?> responseMenuWraps() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu =
        data.where((item) => item['type_categories'] == 'Wraps').toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }

  Future<List<Map<String, dynamic>>?> responseMenuBeverages() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu =
        data.where((item) => item['type_categories'] == 'Beverages').toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }

  Future<List<Map<String, dynamic>>?> responseMenuSandwiches() async {
    final res = await _api.requestSelected(TableSupabase.mennuTable, '*');
    final List<dynamic> data = res ?? [];
    // Filter data to get only the popular menu items
    final popularMenu =
        data.where((item) => item['type_categories'] == 'Sandwiches').toList();
    return List<Map<String, dynamic>>.from(popularMenu);
  }
}
