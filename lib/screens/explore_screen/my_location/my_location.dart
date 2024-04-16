import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/your_locations_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    //
    yourLocations
                .map((yourLocations) => yourLocations.location)
                .contains(_currentAddress.toString()) ==
            true
        ? null
        : yourLocations.length == 5
            ? _showDialog()
            : setState(() {
                yourLocations.add(newMyLocation);
              });
  }

//show Dialog when your locations is more than 5 places
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 150,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColor.grey1.withOpacity(0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Icon(
                Icons.notifications,
                size: 24,
                color: AppColor.red,
              ),
              Text(
                "Your locations is overlimit.Please delete one of them for continuing add new location!",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }

  //update data on supabase
  final supabase = Supabase.instance.client;
  Future<void> _updateDataSupabase() async {
    final userInfo = await supabase
        .from("user_account")
        .select("id")
        .filter(
          "email",
          "eq",
          profileInfo[0].email.toString(),
        )
        .single();
    final userID = userInfo.entries.single.value;
    //
    final userLocations =
        await supabase.from("locations").select("user_id").match(
      {"user_id": userID},
    );

    userLocations.isEmpty
        ? await supabase.from("locations").insert({
            "location_1": yourLocations[0].location.toString(),
            "user_id": userID.toString(),
          })
        : userLocations.single.entries.single.value == userID
            ? await supabase
                .from("locations")
                .update(yourLocations.length == 1
                    ? {
                        "location_1": yourLocations[0].location.toString(),
                        "time_updated": DateTime.now().toString(),
                      }
                    : yourLocations.length == 2
                        ? {
                            "location_1": yourLocations[0].location.toString(),
                            "location_2": yourLocations[1].location.toString(),
                            "time_updated": DateTime.now().toString(),
                          }
                        : yourLocations.length == 3
                            ? {
                                "location_1":
                                    yourLocations[0].location.toString(),
                                "location_2":
                                    yourLocations[1].location.toString(),
                                "location_3":
                                    yourLocations[2].location.toString(),
                                "time_updated": DateTime.now().toString(),
                              }
                            : yourLocations.length == 4
                                ? {
                                    "location_1":
                                        yourLocations[0].location.toString(),
                                    "location_2":
                                        yourLocations[1].location.toString(),
                                    "location_3":
                                        yourLocations[2].location.toString(),
                                    "location_4":
                                        yourLocations[3].location.toString(),
                                    "time_updated": DateTime.now().toString(),
                                  }
                                : yourLocations.length == 5
                                    ? {
                                        "location_1": yourLocations[0]
                                            .location
                                            .toString(),
                                        "location_2": yourLocations[1]
                                            .location
                                            .toString(),
                                        "location_3": yourLocations[2]
                                            .location
                                            .toString(),
                                        "location_4": yourLocations[3]
                                            .location
                                            .toString(),
                                        "location_5": yourLocations[4]
                                            .location
                                            .toString(),
                                        "time_updated":
                                            DateTime.now().toString(),
                                      }
                                    : {
                                        "location_1": "",
                                        "location_2": "",
                                        "location_3": "",
                                        "location_4": "",
                                        "location_5": "",
                                        "time_updated":
                                            DateTime.now().toString(),
                                      })
                .match({
                "user_id": userID,
              })
            : null;
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
            _addMyLocation().whenComplete(() => _updateDataSupabase());
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
                yourLocations.isEmpty
                    ? "Tap here to define your location!"
                    : yourLocations.last.location.toString(),
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
