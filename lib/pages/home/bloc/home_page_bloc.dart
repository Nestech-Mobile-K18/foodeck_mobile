import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomePageSelectIndexEvent>(homePageSelectIndexEvent);
    on<HomePageNavigateEvent>(homePageNavigateEvent);
  }

  FutureOr<void> homePageSelectIndexEvent(
      HomePageSelectIndexEvent event, Emitter<HomePageState> emit) {
    if (event.index == 0) {
      emit(HomePageSelectIndex0State(index: event.index));
    } else if (event.index == 1) {
      emit(HomePageSelectIndex1State(index: event.index));
    } else if (event.index == 2) {
      emit(HomePageSelectIndex2State(index: event.index));
    } else if (event.index == 3) {
      emit(HomePageSelectIndex3State(index: event.index));
    }
  }

  FutureOr<void> homePageNavigateEvent(
      HomePageNavigateEvent event, Emitter<HomePageState> emit) {
    emit(HomePageNavigateActionState());
  }
}
