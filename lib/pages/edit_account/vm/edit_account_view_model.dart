import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/resources/const.dart';

import '../../../services/api.dart';
import '../../../services/auth_manager.dart';
import '../../../services/errror.dart';
import '../../../services/table_supbase.dart';
import '../models/edit_profile_model.dart';
import 'package:crypto/crypto.dart';

class EditAccountViewModel extends ChangeNotifier {
  final API _api = API();
  final EditProfileModel model = EditProfileModel();
  final Validation _validation = Validation();
  final ErrorDialog _showError = ErrorDialog();

  Future<Map<String, dynamic>?> responseProfile() async {
    final String? getUserId = await AuthManager.getUserId();
    if (getUserId == null) {
      return null;
    } else {
      var userResponse = await _api.supabase
          .from(TableSupabase.usersTable)
          .select('email, name, phone, password, avatar')
          .eq(TableSupabase.idColumn, getUserId)
          .single();
      return userResponse;
    }
  }

  Future<String?> uploadAvatarToStorage(XFile file, String userId) async {
    // Get the file path from XFile
    String filePath = file.path;

    // Create a File object from the path
    File imageFile = File(filePath);

    // Create a unique string by combining userId and current time
    String uniqueId = '${userId}_${DateTime.now().millisecondsSinceEpoch}';

    // Hash the unique string to create a unique file name
    String fileName = '${md5.convert(utf8.encode(uniqueId))}.jpg';

    // Perform file push to Supabase Storage

    await _api.supabase.storage.from('users').upload(fileName, imageFile);

    final res = _api.supabase.storage.from('users').getPublicUrl(fileName);
    return res;
  }

  Future<void> requestUpdateProfile(
      EditProfileModel model, BuildContext context) async {
    final String? getUserId = await AuthManager.getUserId();
    if (getUserId == null) {
      return;
    } else {
      // Declare and initialize userdata
      Map<String, dynamic> userdata = {
        TableSupabase.nameColumn: model.name,
        TableSupabase.emailColumn: model.email,
        TableSupabase.phoneColumn: model.phone,
        TableSupabase.passwordColumn: model.password,
      };

      // Get current user information
      Map<String, dynamic>? currentUser = await responseProfile();
      if (currentUser == null) {
        return; // Handle if user information is not found
      }

      // Check if the new password is different from the old password
      bool newPasswordDifferent = model.password != currentUser['password'];

      // Check if avatarPath is provided and it's not null
      if (model.avatarPath != null) {
        XFile? imageFile = XFile(model.avatarPath!);
        // Upload avatar to Supabase Storage
        String? avatarUrl = await uploadAvatarToStorage(imageFile, getUserId);
        if (avatarUrl != null) {
          // If upload is successful, update userdata with avatar URL
          userdata['avatar'] = avatarUrl;
        } else {
          // Handle error if avatar upload fails
          // For example, show a message to the user
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to upload avatar.'),
            ),
          );
          return;
        }
      }

      // Update user data in Supabase Users table
      await _api.supabase
          .from(TableSupabase.usersTable)
          .update(userdata)
          .eq(TableSupabase.idColumn, getUserId);

      // Check if the password has been changed and it's different from the old password
      if (model.password != null &&
          model.password != '' &&
          newPasswordDifferent) {
        // Update email in Supabase Authentication
        await _api.supabase.auth.updateUser(
          UserAttributes(
            data: userdata,
            password: model.password,
          ),
        );
      } else {
        // If the password has not been changed or it's the same as the old password, update other user data only
        await _api.supabase.auth.updateUser(
          UserAttributes(
            data: {
              TableSupabase.nameColumn: model.name,
              TableSupabase.emailColumn: model.email,
              TableSupabase.phoneColumn: model.phone,
              'avatar': model.avatarPath
            },
          ),
        );
      }
    }
  }

  void authenUpdate(EditProfileModel input, BuildContext context) async {
    if (input.name!.isEmpty ||
        input.email!.isEmpty ||
        input.phone!.isEmpty ||
        input.password!.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Missing Information"),
            content: const Text("Please fill in all the fields."),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(StringExtensions.oke))
            ],
          );
        },
      );
    } else {
      if (!_validation.isNameValid(input.name!)) {
        _showError.showError(context, 'Invalid name !');
      } else if (!_validation.isPhoneValid(input.phone!)) {
        _showError.showError(context, 'invalid phone number !');
      } else if (!_validation.isPasswordValid(input.password!)) {
        _showError.showError(context,
            'Invalid password, Must have at least 1 uppercase letter, 1 lowercase letter and 1 special character');
      } else {
        try {
          await requestUpdateProfile(input, context);
          // If there is no error during profile update, pop the context
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        } on AuthApiException catch (e) {
          if (e.message ==
              'New password should be different from the old password.') {

            // ignore: use_build_context_synchronously
            _showError.showError(context,
                'New password should be different from the old password.');
          } else {
            // Handle other AuthApiException if needed
          }
        }
      }
    }
  }

  Future<XFile?> requestStoragePermission(BuildContext context) async {
    // Check if access to the photo store has been granted
    var status = await Permission.photos.request();
    if (status.isGranted) {
      // If permission has been granted, select a photo from the gallery
      final picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      return pickedFile;
    } else if (status.isPermanentlyDenied) {
      // If permission is permanently denied, display instructions on how to grant permission in device settings
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is permanently denied.'),
        ),
      );
    } else {
      // If permission has not been granted, display a permission request message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required.'),
        ),
      );
    }
    return null; // Returns null if no image is selected
  }
}
