import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:template/src/features/location/bloc/location_bloc.dart';
import 'package:template/src/features/restaurant/data/model.dart';
import 'package:template/src/services/restaurant_service.dart';
import 'package:template/src/utils/helpers/cal_move_time.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantService _restaunrantService;
  StreamSubscription<LocationState>? locationSubscription;

  RestaurantBloc(this._restaunrantService) : super(RestaurantInitial()) {
    on<RestaurantListStarted>(_onRestaurantInforStarted);
    // on<CalMoveTimeStarted>(_onRestaurantInforStarted);
  }

  // get restaurant information in explore page
  Future<void> _onRestaurantInforStarted(
      RestaurantListStarted event, Emitter<RestaurantState> emit) async {
    emit(RestaurantListInProgress());
    try {
      List<CalMoveTime>? calMoveTimes =
          await _restaunrantService.getCalMoveTime();

      List<RestaurantInfo>? response = await _restaunrantService
          .getRestaurants(RestaurantRequest(size: event.size));

      //get current location
      LocationData? currentLocation;
      if (event.locationBloc.state is CurrentLocationSuccess) {
        currentLocation = (event.locationBloc.state as CurrentLocationSuccess)
            .currentLocation;
      }

      // cal dis, time move
      for (int i = 0; i < response!.length; i++) {
        double distanceInKm = Geolocator.distanceBetween(
                response[i].address!.lat,
                response[i].address!.lng,
                currentLocation!.latitude!,
                currentLocation.longitude!) /
            1000;

        response[i].distance = double.parse(distanceInKm.toStringAsFixed(2));
        Map<String, dynamic> timeMove =
            getTimeMove(distanceInKm, calMoveTimes!);
        response[i].timeUnit = timeMove['unit'];
        response[i].time = timeMove['time'];
      }
      emit(RestaurantListSuccess(restaurants: response));
    } catch (e) {
      emit(RestaurantListFailure());
    }
  }
}
