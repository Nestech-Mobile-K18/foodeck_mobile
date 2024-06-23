import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/src/pages/export.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  var _isGettingLocation = false;
  late double _lat = 0;
  late double _lng = 0;
  late final List<CoordinatesData> _coordinatesDatas;
  @override
  void initState() {
    _coordinatesDatas = coordinatesDatas;
    //khoi tao get current location
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    LocationData? locationData;

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await getCurrentLocation();

    setState(() {
      _isGettingLocation = false;
    });

    //update lat, long
    _lat = locationData!.latitude!;
    _lng = locationData.longitude!;
  }

Future<void> _handleAddLocation()async{
  Navigator.of(context).pushNamed(RouteName.addLocation);
}
  @override
  Widget build(BuildContext context) {
    Widget prviewContent = FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(_lat, _lng),
        initialZoom: 19,
        minZoom: 0,
        maxZoom: 19,
      ),
      children: [
        //get image map
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName:
              'net.tlserver6y.flutter_map_location_marker.example',
          maxZoom: 19,
        ),
        // định vị vị trí location trên hình
        CurrentLocationLayer(
          followOnLocationUpdate: FollowOnLocationUpdate.always,
          turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
    if (_isGettingLocation) {
      prviewContent = SizedBox(
        height: AppSize.s54,
        width: AppSize.s54,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBarScreen(
        title: AppStrings.myLocations,
        isAction: true,
        icon: IconButton(
            onPressed: _handleAddLocation,
            icon: const Icon(
              Icons.add,
              color: ColorsGlobal.globalPink,
            )),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: prviewContent,
          ),
          Positioned(
            right: AppPadding.p24,
            bottom: AppPadding.p150,
            child: RawMaterialButton(
              onPressed: _getCurrentLocation,
              elevation: 2.0,
              fillColor: ColorsGlobal.globalPink,
              padding: EdgeInsets.all(AppPadding.p10),
              shape: const CircleBorder(),
              // ignore: prefer_const_constructors
              child: Icon(
                Icons.my_location_outlined,
                color: ColorsGlobal.white,
              ),
            ),
          ),
          // list my location
          Positioned(
            left: AppPadding.p0,
            right: AppPadding.p0,
            bottom: AppPadding.p24,
            child: SizedBox(
              height: AppSize.s100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _coordinatesDatas.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.p12),
                        child: LocationInfo(
                          address: _coordinatesDatas[index].address!,
                          locationName: _coordinatesDatas[index].locationName!,
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
