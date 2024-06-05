import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:template/main.dart';
import 'package:template/routes/routes.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  SplashPageBloc() : super(SplashPageInitial()) {
    on<SplashPageInitialEvent>(splashPageInitialEvent);
  }

  void initializeLocationAndSave() async {
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

  Future<void> getInitialProfile() async {
    late dynamic id;
    var response = await supabase.from('users').select('id');
    var records = response.toList() as List;
    for (var record in records) {
      var userId = record['id'];
      id = userId;
    }
    final data = await supabase.from('users').select().eq('id', id).single();
    sharedPreferences.setString('avatar', data['avatar_url']);
    sharedPreferences.setString('name', data['full_name']);
    sharedPreferences.setString('email', data['email']);
    sharedPreferences.setString('phone', data['phone']);
    sharedPreferences.setString('password', data['password']);
  }

  void authState() {
    supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.homePage);
      } else if (session == null) {
        AppRouter.navigatorKey.currentState!.pushNamed(AppRouter.loginPage);
      }
    });
  }

  FutureOr<void> splashPageInitialEvent(
      SplashPageInitialEvent event, Emitter<SplashPageState> emit) async {
    initializeLocationAndSave();
    getInitialProfile();
    emit(SplashLoadingAnimationState());
    await Future.delayed(const Duration(milliseconds: 3000));
    emit(SplashLoadingAnimationSecondState());
    await Future.delayed(const Duration(milliseconds: 3000));
    emit(SplashLoadingAnimationThirdState());
    await Future.delayed(const Duration(milliseconds: 3500));
    emit(SplashLoadingAnimationFourthState());
    await Future.delayed(const Duration(milliseconds: 1500));
    authState();
  }
}
