import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';

import '../../../services/auth_manager.dart';

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
      // Lấy danh sách menu đã được like của người dùng
      final userRecord = await supabase
          .from('users')
          .select('list_like')
          .eq('id', userId)
          .single();

      // Lấy danh sách menu đã like từ kết quả truy vấn
      final dynamic likedMenus = userRecord['list_like'];
      List<String> updatedList = [];

      if (likedMenus != null) {
        if (likedMenus is List<dynamic>) {
          // Nếu likedMenus là một List, thêm toàn bộ các phần tử vào updatedList
          updatedList.addAll(likedMenus.map((item) => item.toString()));
        } else {
          // Nếu likedMenus không phải là List, thêm nó vào updatedList
          updatedList.add(likedMenus.toString());
        }

        // Nếu menuId chưa tồn tại trong danh sách, thêm vào danh sách
        if (!updatedList.contains(menuId)) {
          updatedList.add(menuId);
        }
      } else {
        // Nếu danh sách menu là null, tạo danh sách mới và thêm menuId vào
        updatedList.add(menuId);
      }

      // Cập nhật danh sách menu đã like của người dùng trên cơ sở dữ liệu
      await supabase
          .from('users')
          .update({'list_like': updatedList}).eq('id', userId);
    }
  }

  Future<void> requestDeleteIsLike(String userId, String menuId) async {
    // Lấy danh sách menu đã được like của người dùng
    final userRecord = await supabase
        .from('users')
        .select('list_like')
        .eq('id', userId)
        .single();

    // Lấy danh sách menu đã like từ kết quả truy vấn
    final dynamic likedMenus = userRecord['list_like'];
    List<String> updatedList = [];

    if (likedMenus != null) {
      if (likedMenus is List<dynamic>) {
        // Nếu likedMenus là một List, thêm toàn bộ các phần tử vào updatedList
        updatedList.addAll(likedMenus.map((item) => item.toString()));
      } else {
        // Nếu likedMenus không phải là List, thêm nó vào updatedList
        updatedList.add(likedMenus.toString());
      }

      // Xóa menuId khỏi danh sách
      updatedList.remove(menuId);
    }

    // Kiểm tra xem danh sách đã trở thành rỗng chưa
    if (updatedList.isEmpty) {
      // Nếu danh sách rỗng, cập nhật cột list_like với giá trị là một danh sách trống
      await supabase.from('users').update({'list_like': []}).eq('id', userId);
    } else {
      // Nếu danh sách không rỗng, cập nhật danh sách menu đã like của người dùng trên cơ sở dữ liệu
      await supabase
          .from('users')
          .update({'list_like': updatedList}).eq('id', userId);
    }
  }
}
