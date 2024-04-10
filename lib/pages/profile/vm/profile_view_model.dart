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

  Future<Map<String, dynamic>?> getUserDataById() async {
    // Make sure to await the responseUserId to get the actual ID
    final String? getUserId = await responseUserId();
    if (getUserId == null) {
      // Handle the case where getUserId is null if necessary

      return null;
    }
    final userResponse = await supabaseClient
        .from('users')
        .select('email, name, phone, password')
        .eq('id', getUserId)
        .single();
    final addressResponse = await supabaseClient
        .from('location_user')
        .select('address_1')
        .eq('user_id', getUserId)
        .single();

    Map<String, dynamic> joinedData = joinMaps(userResponse, addressResponse);
    return joinedData;
  }

  Map<String, dynamic> joinMaps(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    Map<String, dynamic> result = {};
    result.addAll(map1);
    result.addAll(map2);
    return result;
  }
}
