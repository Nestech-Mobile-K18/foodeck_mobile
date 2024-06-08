import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:template/data/saved_list_data.dart';
import 'package:template/features/explore/bloc/explore_page_bloc.dart';
import 'package:template/main.dart';
import 'package:template/routes/routes.dart';
import 'package:template/values/colors.dart';
import 'package:template/widgets/custom_snack_bar.dart';

class CommonUtils {
  static initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    // Get capture the current user location
    LocationData locationData = await location.getLocation();
    // Store the user location in sharedPreferences
    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
  }

  static authState() {
    supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.homePage);
      } else if (session == null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.loginPage);
      }
    });
  }

  static getInitialProfile() async {
    late dynamic id;
    var response = await supabase.from('users').select('id');
    var records = response.toList() as List;
    for (var record in records) {
      var userId = record['id'];
      id = userId;
    }
    final data = await supabase.from('users').select().eq('id', id).single();
    sharedPreferences.setString('avatar', data['avatar_url'] ?? '');
    sharedPreferences.setString('name', data['full_name'] ?? '');
    sharedPreferences.setString('email', data['email'] ?? '');
    sharedPreferences.setString('phone', data['phone'] ?? '');
    sharedPreferences.setString('password', data['password'] ?? '');
  }

  static toggleLike(ExplorePageLikeState state, BuildContext context) {
    if (!SavedListData.saveFood.contains(state.restaurantModel)) {
      customSnackBar(
          context, AppColor.buttonShadowBlack, 'You just unliked this item');
    } else {
      customSnackBar(
          context, AppColor.globalPinkShadow, 'You just liked this item');
    }
  }
}
