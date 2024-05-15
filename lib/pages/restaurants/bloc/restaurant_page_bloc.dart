import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:template/values/list.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc
    extends Bloc<RestaurantPageEvent, RestaurantPageState> {
  RestaurantPageBloc() : super(RestaurantPageInitial()) {
    on<RestaurantPageBackEvent>(restaurantPageBackEvent);
  }

  FutureOr<void> restaurantPageBackEvent(
      RestaurantPageBackEvent event, Emitter<RestaurantPageState> emit) {}
}
