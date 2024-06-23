import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:template/src/pages/export.dart';

Future<String?> getAddress(double latitude, double longitude) async {
  try {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      geocoding.Placemark placemark = placemarks[0];
      print(placemark);
      return '${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}' ??
          '';
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<String?> getLocationName (double latitude, double longitude) async {
  try {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      geocoding.Placemark placemark = placemarks[0];
      print(placemark);
      return placemark.name ?? '';
    }
  } catch (e) {
    print('Error: $e');
    return null;

  }
}

Future<List<geocoding.Location>> getCoordinates(String locationName) async {
  try {
    List<geocoding.Location> locations =
        await geocoding.locationFromAddress(locationName);
    return locations;
  } catch (e) {
    print('Error: $e');
  }
  return [];
}

Future<LocationData?> getCurrentLocation() async {
  print('get location');
  Location location = new Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  locationData = await location.getLocation();
  print('current location: $locationData');
  return locationData;
}

Future<bool> checkPermission(
    LocationData locationData, Location location) async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return false;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  return true;
}

