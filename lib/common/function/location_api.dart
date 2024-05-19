import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:template/common/model/coordinates_data.dart';

class Deley {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Deley({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds), action);
  }
}

class LocationApi extends ChangeNotifier {
  List<CoordinatesData> places = [];

  var addressController = TextEditingController();

  var _deley = Deley(milliseconds: 0);

  final _controller = StreamController<List<CoordinatesData>>.broadcast();
  Stream<List<CoordinatesData>> get controllerOut =>
      _controller.stream.asBroadcastStream();

  StreamSink<List<CoordinatesData>> get controllerIn => _controller.sink;
  static String country = 'Việt Nam';

  addPlace(CoordinatesData place) {
    places.add(place);
    controllerIn.add(places);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  Future<List<CoordinatesData>> handleSearch(String query) async {
    List<CoordinatesData> results = [];
    if (query.isNotEmpty) {
      await Future.delayed(Duration(seconds: 1)); // Introduce a 1-second delay

      try {
        List<Location> locations =
            await locationFromAddress('$query, $country');
        for (Location location in locations) {
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          for (Placemark placeMark in placeMarks) {
            // print('location: $placeMark');
            CoordinatesData result = CoordinatesData(
              locationName: placeMark.name!,
              street: placeMark.street,
              locality: placeMark.locality,
              country: placeMark.country,
              address:
                  '${placeMark.street}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea}, ${placeMark.country}' ??
                      '',
            );
            results.add(result);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      // places.clear();
      results.clear();
    }
    return results;
  }
}
