import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:template/common/function/location_api.dart';
import 'package:template/pages/export.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  var _isGettingLocation = false;
  late double _lat = 0;
  late double _lng = 0;

  double _initialSheetChildSize = 0.2;


  final TextEditingController _controllerSearchAddress =
      new TextEditingController();
  late final FocusNode _focusNodeSearchAddress;
  List<CoordinatesData> _resultAddressList = [];
// List<CoordinatesData> list =
  @override
  void initState() {
    _focusNodeSearchAddress = FocusNode();
    //khoi tao get current location
    _getCurrentLocation();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     // render the floating button on widget
    //     _fabPosition = _initialSheetChildSize * context.size!.height;
    //   });
    // });
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

  void getResult(String value) {
    LocationApi().handleSearch(value).then((results) {
      setState(() {
        _resultAddressList = results;
      });
      print('Results: $_resultAddressList');
    }).catchError((error) {
      print('Error occurred: $error');
    });
  }

  @override
  void dispose() {
    _controllerSearchAddress.dispose();
    _focusNodeSearchAddress.dispose();
    super.dispose();
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
            onPressed: () {},
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
          DraggableScrollableSheet(
            // initialChildSize: 0.2,
            initialChildSize: _initialSheetChildSize,
            maxChildSize: 0.8,
            minChildSize: 0.1,
            builder: (context, scrollController) {
              return Container(
                color: ColorsGlobal.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(AppMargin.m10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorsGlobal
                                    .grey, // Set the border color for the Container
                                width: AppSize
                                    .s1 // Set the border width for the Container
                                ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppRadius.r16))),
                        child: SearchItemBar(
                          controller: _controllerSearchAddress,
                          focusNode: _focusNodeSearchAddress,
                          onChanged: (value) {
                              getResult(value);
                          },
                        ),
                      ),
                      ListView.builder(
                        physics:
                            const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: _resultAddressList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(AppPadding.p12),
                                child: LocationInfo(
                                  address: _resultAddressList[index].address!,
                                  locationName:
                                      _resultAddressList[index].locationName,
                                ),
                              ));
                          //  ListTile(
                          //   title: Text(_resultAddressList[index].locationName),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
