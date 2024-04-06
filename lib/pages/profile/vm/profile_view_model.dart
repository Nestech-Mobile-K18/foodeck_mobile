import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewModel {
  final supabaseClient = Supabase.instance.client;

  Future<String?> responseUserId() async {
    String? getUserId;
    var res = await supabaseClient.from('users').select('id');
    // Assuming you want to work with the data as a List of Maps.
    // Please note that you might need to adjust this part according to the actual structure of your data.
    var records = res.toList() as List?;
    if (records != null && records.isNotEmpty) {
      // Get the ID from the first record
      var record = records.first;
      getUserId = record['id'].toString();
    }
    return getUserId;
  }

  Future<List<dynamic>?> getUserDataById() async {
    // Make sure to await the responseUserId to get the actual ID
    final String? getUserId = await responseUserId();
    if (getUserId == null) {
      // Handle the case where getUserId is null if necessary

      return null;
    }
    final response = await supabaseClient
        .from('users')
        .select('email, name, phone, address, password')
        .eq('id', getUserId);

    return response;
  }
}
