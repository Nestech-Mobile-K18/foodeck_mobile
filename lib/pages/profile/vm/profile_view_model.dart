import 'package:image_picker/image_picker.dart';
import 'package:template/services/api.dart';
import 'package:template/services/table_supbase.dart';

import '../../../services/auth_manager.dart';

/// A view model for managing profile-related data and interactions.
class ProfileViewModel {
  final API _api = API();

  // Retrieves user data from the 'users' and 'location_user' tables based on the user ID.
  Stream<Map<String, dynamic>?> getUserDataByIdStream() async* {
    final String? getUserId = await AuthManager.getUserId();
    if (getUserId == null) {
      yield null;
      return;
    }

    while (true) {
      var locationColumns = [
        TableSupabase.addressColumn1,
        TableSupabase.addressColumn2,
        TableSupabase.addressColumn3,
        TableSupabase.addressColumn4,
        TableSupabase.addressColumn5
      ];
      var userResponse;
      Map<String, String?> addressResponse = {};

      for (var addressColumn in locationColumns) {
        var response = await _api.supabase
            .from(TableSupabase.localUserTable)
            .select(addressColumn)
            .eq(TableSupabase.userIdColumn, getUserId)
            .single();

        var address = response[addressColumn] as String?;
        if (address != null) {
          userResponse = await _api.supabase
              .from(TableSupabase.usersTable)
              .select('email, name, phone, password, avatar')
              .eq(TableSupabase.idColumn, getUserId)
              .single();
          addressResponse['address'] = address;
          break;
        }
      }

      if (userResponse == null) {
        yield null;
        return;
      }

      Map<String, dynamic> joinedData = joinMaps(userResponse, addressResponse);
      yield joinedData;

      await Future.delayed(
          const Duration(seconds: 5)); // Waiting time before receiving new data
    }
  }

  // Joins two maps into a single map.
  Map<String, dynamic> joinMaps(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    Map<String, dynamic> result = {};
    result.addAll(map1);
    result.addAll(map2);
    return result;
  }

  XFile? convertAvatarToXFile(String? avatarPath) {
    if (avatarPath == null) {
      return null; // Returns null if there is no path
    } else {
      // Perform conversion from String to XFile
      return XFile(avatarPath);
    }
  }



}
