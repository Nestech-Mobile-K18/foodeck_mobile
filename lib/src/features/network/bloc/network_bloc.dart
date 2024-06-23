import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  // static final NetworkBloc _instance = NetworkBloc._();

  // StreamSubscription _subscription;

  // factory NetworkBloc() => _instance;

  NetworkBloc() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    //  on<NetworkStarted>(_notifyStatus);
  }

  void _observe(event, emit) async {
   await for (var results in Connectivity().onConnectivityChanged) {
    ConnectivityResult result = results.last;
    if (result == ConnectivityResult.none) {
      emit(NetworkFailure());
    } else {
      emit(NetworkSuccess());
    }
  }
  }

  
}
