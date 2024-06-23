part of 'location_bloc.dart';

sealed class LocationEvent {}

class CurrentLocationStarted extends LocationEvent {
  CurrentLocationStarted({
    this.lat,
    this.lng,
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.subadministrativeArea,
    this.thoroughfare,
    this.subthoroughfare,
  });

  final double? lat;
  final double? lng;
  final String? name;
  final String? street;
  final String? isoCountryCode;
  final String? country;
  final String? subadministrativeArea;
  final String? thoroughfare;
  final String? subthoroughfare;
}
