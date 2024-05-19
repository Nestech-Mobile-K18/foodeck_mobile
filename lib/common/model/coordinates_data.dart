class CoordinatesData {
   double? lat;
    double? lng;
    String locationName;
    String address;
    //  String name;
    String? street;
    String? locality;
    String? country;
  CoordinatesData({this.lat, this.lng, required this.locationName, required this.address, this.street, this.locality, this.country});
}
