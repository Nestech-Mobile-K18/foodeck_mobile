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

  Future<List<String>> getListLikeFoodIds(String userId) async {
    final userRecord = await supabase
        .from('users')
        .select('like_food')
        .eq('id', userId)
        .single();
    final dynamic likedMenus = userRecord['like_food'];
    List<String> foodIds = [];
    if (likedMenus != null) {
      if (likedMenus is List<dynamic>) {
        foodIds.addAll(likedMenus.map((item) => item.toString()));
      } else {
        foodIds.add(likedMenus.toString());
      }
    }

    return foodIds;
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

  Future<void> requestUpdateLikeFood(String foodId) async {
    final String? userId = await AuthManager.getUserId();
    if (userId != null) {
      // Get the list of menus that have been liked by the user
      final userRecord = await supabase
          .from('users')
          .select('like_food')
          .eq('id', userId)
          .single();
      // Get the list of liked menus from the query results
      final dynamic likedFoods = userRecord['like_food'];
      List<String> updatedList = [];

      if (likedFoods != null) {
        if (likedFoods is List<dynamic>) {
          // If likedMenus is a List, add all elements to the updatedList
          updatedList.addAll(likedFoods.map((item) => item.toString()));
        } else {
          // If likedMenus is not a List, add it to updatedList
          updatedList.add(likedFoods.toString());
        }
        // If menuId does not exist in the list, add it to the list
        if (!updatedList.contains(foodId)) {
          updatedList.add(foodId);
        }
      } else {
        // If the menu list is null, create a new list and add menuId
        updatedList.add(foodId);
      }
      // Update the list of user's liked menus on the database
      await supabase
          .from('users')
          .update({'like_food': updatedList}).eq('id', userId);
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

  Future<void> requestDeleteLikeFood(String userId, String foodId) async {
    // Get the list of menus that have been liked by the user
    final userRecord = await supabase
        .from('users')
        .select('like_food')
        .eq('id', userId)
        .single();
    // Get the list of liked menus from the query results
    final dynamic likedMenus = userRecord['like_food'];
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
      updatedList.remove(foodId);
    }

    // Check if the list has become empty
    if (updatedList.isEmpty) {
      // If the list is empty, update the list_like column with the value of an empty list
      await supabase.from('users').update({'like_food': []}).eq('id', userId);
    } else {
      // If the list is not empty, update the user's liked menu list on the database
      await supabase
          .from('users')
          .update({'like_food': updatedList}).eq('id', userId);
    }
  }

  double calculatePrice({
    required Map<String, dynamic>? variationMap,
    required String? selectedVariation,
    required Map<String, dynamic>? extraSauceMap,
    required List<String> selectedExtraSauce,
    required int quantity,
    required Map<String, dynamic>? bindingData,
  }) {
    double totalPrice = 0.0;

    if (variationMap != null && selectedVariation != null) {
      totalPrice += (variationMap[selectedVariation] as num).toDouble();
    } else if (bindingData != null && bindingData.containsKey('price')) {
      totalPrice += (bindingData['price'] as num).toDouble();
    }

    if (extraSauceMap != null) {
      for (var sauce in selectedExtraSauce) {
        if (extraSauceMap[sauce] != null) {
          totalPrice += (extraSauceMap[sauce] as num).toDouble();
        }
      }
    }
    totalPrice *= quantity;
    return totalPrice;
  }
  Future<void> requestAddToCart({
    required BuildContext context,
    required Map<String, dynamic> foodData,
    required Map<String, dynamic>? extraSauceMap,
    required Map<String, dynamic>? variationMap,
    required List<String>? selectedExtraSauce,
    required String? selectedVariation,
    required int quantity,
    required double totalPrice,
  }) async {
    final userId = await AuthManager.getUserId();
    if (userId != null) {
      final userRecord = await supabase
          .from('users')
          .select('id')
          .eq('id', userId)
          .single();

      if (userRecord.containsKey('id')) {
        final response = await supabase
            .from('cart')
            .select()
            .eq('user_id', userId)
            .maybeSingle(); // Use maybeSingle to avoid errors when no rows are returned

        final cartData = response;

        if (cartData != null && cartData.containsKey('list_cart')) {
          List<dynamic> cartList = cartData['list_cart'];
          bool itemFound = false;

          // Use a loop to find products in the user's cart
          for (var item in cartList) {
            if (item['id_food'] == foodData['id_food']) {
              // If the product is already in the cart, update the quantity and price
              item['quantity'] += quantity;
              item['price'] = (double.parse(item['price']) + totalPrice);
              itemFound = true;
              break;
            }
          }

          if (!itemFound) {
            // If the product is not in the cart, add the product to the cart
            cartList.add({
              'id_food': foodData['id_food'],
              'food_name': foodData['food_name'],
              'bonus': foodData['bonus'],
              'image_food': foodData['image_food'],
              'address_restaurant': foodData['address_restaurant'],
              'extra_sauce': extraSauceMap != null ? selectedExtraSauce : null,
              'variation': variationMap != null ? selectedVariation : null,
              'quantity': quantity,
              'price': totalPrice,
            });
          }

          // Update the shopping cart in the database
          await supabase
              .from('cart')
              .update({'list_cart': cartList}).eq('user_id', userId);
        } else {
          // If there is no shopping cart, create a new one and add products
          final newCartRecord = {
            'user_id': userId,
            'list_cart': [
              {
                'id_food': foodData['id_food'],
                'food_name': foodData['food_name'],
                'bonus': foodData['bonus'],
                'image_food': foodData['image_food'],
                'address_restaurant': foodData['address_restaurant'],
                'extra_sauce': extraSauceMap != null ? selectedExtraSauce : null,
                'variation': variationMap != null ? selectedVariation : null,
                'quantity': quantity,
                'price': totalPrice,
              }
            ],
          };

          // Add new cart to database
          await supabase.from('cart').insert(newCartRecord);
        }

         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Add to cart successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        return ;
      }
    } else {
      return ;
    }
  }


}
