import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyReviewsViewModel extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> fetchMenu() async {
    // Create a query to get data from the menu table
    final response = await supabase.from('menu').select();
    // Returns a list of rows from the menu table
    return response;
  }
}
