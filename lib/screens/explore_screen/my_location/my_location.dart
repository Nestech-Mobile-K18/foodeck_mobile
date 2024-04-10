import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/your_locations_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  ///
  String? _currentAddress;
  //
  Future<Object?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return _currentAddress;
  }

  Future<void> _addMyLocation() async {
    

    Position position = await Geolocator.getCurrentPosition();

    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      _currentAddress =
          '${place.street}, ${place.subAdministrativeArea},${place.administrativeArea}, ${place.isoCountryCode}';
    }).catchError((e) {
      debugPrint(e);
    });
    final newMyLocation = YourLocationsInfo(
      location: _currentAddress.toString().trim(),
      kind: '',
    );
yourLocations.map((yourLocations) => yourLocations.location).contains(_currentAddress.toString())==true
   ? null
    :setState(() {
      yourLocations.add(newMyLocation);
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      margin: const EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          setState(() {
            _determinePosition();
            _addMyLocation();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 24,
              color: AppColor.white,
            ),
            SizedBox(
              width: 300,
              child: Text(
                "  ${_currentAddress ?? "Unknow address"}",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
