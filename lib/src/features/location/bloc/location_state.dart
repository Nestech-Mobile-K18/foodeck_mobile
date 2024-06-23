part of 'location_bloc.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {
  final LocationData? currentLocation;
  final bool isLoading;
  final String? address;
  final String? locationName;

  LocationInitial({
    this.currentLocation= null,
    this.isLoading = false,
    this.address = '',
    this.locationName = '',
  });
}

class CurrentLocationInProgress extends LocationState {
  final bool loading;

  CurrentLocationInProgress({this.loading = true});
}

class CurrentLocationSuccess extends LocationState {
  final LocationData? currentLocation;
  final String? address;
  final String? locationName;
  // final bool isLoading;

  CurrentLocationSuccess({
    this.currentLocation,
    this.address,
    this.locationName,
  });
}

class CurrentLocationFailure extends LocationState {
  final LocationData? currentLocation;
  final String? address;
  final String? locationName;

  CurrentLocationFailure({
    this.currentLocation,
    this.address = '',
    this.locationName = '',
  });
}

// class Location
class LocationReset extends LocationInitial {}
