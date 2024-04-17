import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/auth_manager.dart';

/// A view model for managing profile-related data and interactions.
class ProfileViewModel {
  /// The Supabase client instance.
  final supabaseClient = Supabase.instance.client;

  /// Retrieves user data from the 'users' and 'location_user' tables based on the user ID.
  Future<Map<String, dynamic>?> getUserDataById() async {
    final String? getUserId = await AuthManager.getUserId();
    if (getUserId == null) {
      return null;
    }

    var locationColumns = [
      'address_1',
      'address_2',
      'address_3',
      'address_4',
      'address_5'
    ];
    var userResponse;
    Map<String, String?> addressResponse = {};

    for (var addressColumn in locationColumns) {
      var response = await supabaseClient
          .from('location_user')
          .select(addressColumn)
          .eq('user_id', getUserId)
          .single();

      var address = response[addressColumn] as String?;
      if (address != null) {
        userResponse = await supabaseClient
            .from('users')
            .select('email, name, phone, password')
            .eq('id', getUserId)
            .single();
        addressResponse['address'] = address;
        break;
      }
    }

    if (userResponse == null) {
      return null;
    }

    Map<String, dynamic> joinedData = joinMaps(userResponse, addressResponse);
    return joinedData;
  }

  /// Joins two maps into a single map.
  Map<String, dynamic> joinMaps(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    Map<String, dynamic> result = {};
    result.addAll(map1);
    result.addAll(map2);
    return result;
  }
}
