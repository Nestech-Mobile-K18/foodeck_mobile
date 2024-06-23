// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/src/app.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/features/cal_move_time/bloc/cal_move_time_bloc.dart';
import 'package:template/src/features/location/bloc/location_bloc.dart';
import 'package:template/src/features/network/bloc/network_bloc.dart';
import 'package:template/src/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:template/src/features/signup/bloc/signup_bloc.dart';
import 'package:template/src/services/authentication_service.dart';
import 'package:template/src/services/cal_mode_time_service.dart';
import 'package:template/src/services/location_service.dart';
import 'package:template/src/services/restaurant_service.dart';
import 'package:template/src/services/signup_service.dart';
import 'pages/export.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final AuthenticationService _authService = AuthenticationService();
  final SignUpService _signupService = SignUpService();
  final LocationService _locationService = LocationService();
  final RestaurantService _restaunrantService=RestaurantService();
   final CalMoveTimeService _calMoveTimeService=CalMoveTimeService();

  //  final CalMoveTimeBloc _calMoveTimeBloc=CalMoveTimeBloc(_calMoveTimeService);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(_authService),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(_signupService),
        ),
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(_locationService),
        ),
          BlocProvider<NetworkBloc>(
          create: (context) => NetworkBloc(),
        ),
         BlocProvider<RestaurantBloc>(
          create: (context) => RestaurantBloc(_restaunrantService),
        ),
          BlocProvider<CalMoveTimeBloc>(
          create: (context) => CalMoveTimeBloc(_calMoveTimeService),
        ),
      ],
      child: const MyApp(),
    );
  }
}
