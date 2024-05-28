import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/auth_manager.dart';

class MyOrderViewModel {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchProposedFood() async {
    try {
      // Query data from table 'food' with condition 'propose' is true
      final response =
          await supabase.from('food').select('*').eq('propose', true);

      // Returns a list of recommended dishes
      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      // Handle errors (can log or notify user)
      if (kDebugMode) {
        print('Error fetching proposed food: $error');
      }
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    try {
      // Query all data from 'order' table
      final response = await supabase.from('order').select('*');

      // Convert the value in column 'created_at' to the desired format
      final List<Map<String, dynamic>> orders =
          List<Map<String, dynamic>>.from(response);
      for (var order in orders) {
        order['created_at'] = convertDateTime(order['created_at']);
      }

      // Returns a list of orders
      return orders;
    } catch (error) {
      // Handle errors (can log or notify user)
      if (kDebugMode) {
        print('Error fetching orders: $error');
      }
      return [];
    }
  }

  // Method to convert date string
  String convertDateTime(String dateTimeString) {
    // Convert date string to DateTime format
    final dateTime = DateTime.parse(dateTimeString);

    // Use DateFormat to reformat the date string
    final formattedDate = DateFormat.yMMMMd().format(dateTime);

    return formattedDate;
  }

  Future<void> deleteOrder(String idOrder) async {
    try {
      // Execute query to delete orders based on id_order
      final String? userId = await AuthManager.getUserId();
      await supabase.from('order').delete().eq('id_order', idOrder);

      await supabase.from('cart').delete().eq('user_id', userId ??'');
    } catch (error) {
      // Error handling (can log or notify user)
      if (kDebugMode) {
        print('Error deleting order: $error');
      }
    }
  }
}
