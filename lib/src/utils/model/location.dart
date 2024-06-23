class LocationInfor {
  final int? id;
  final double lat;
  final double lng;
  final String? name;
  final String? street;
  final String? isoCountryCode;
  final String? country;
  final String? subadministrativeArea;
  final String? thoroughfare;
  final String? subthoroughfare;
  final String? deletedDate;
  final String? administrativeArea;

  const LocationInfor(
      {this.id,
      this.lat=0.0,
      this.lng=0.0,
      this.name,
      this.street,
      this.isoCountryCode,
      this.country,
      this.subadministrativeArea,
      this.thoroughfare,
      this.subthoroughfare,
      this.deletedDate,
      this.administrativeArea});

  static LocationInfor empty() {
    return const LocationInfor();
  }

  factory LocationInfor.fromJson(Map<String, dynamic> json) {
    return LocationInfor(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lng: json['long'] ?? 0.0,
      lat: json['lat'] ?? 0.0,
      thoroughfare: json['thoroughfare'] ?? '',
      deletedDate: json['deleted_date'] ?? '',
      street: json['street'] ?? '',
      isoCountryCode: json['iso_country_code'] ?? '',
      country: json['country'] ?? '',
      administrativeArea: json['laadministrative_area'] ?? '',
      subadministrativeArea: json['subadministrative_area'] ?? '',
      subthoroughfare: json['subthoroughfare'] ?? '',
    );
  }
}

List<LocationInfor> mapResponseTolocationList(dynamic response) {
  List<LocationInfor> locationList = [];

  if (response is List) {
    for (var item in response) {
      if (item is Map<String, dynamic>) {
        LocationInfor location = LocationInfor.fromJson(item);
        locationList.add(location);
      }
    }
  }

  return locationList;
}