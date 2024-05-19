import 'package:template/pages/export.dart';

class AppBarExplore extends StatefulWidget {
  const AppBarExplore(
      {Key? key, required this.controller, required this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  @override
  _AppBarExploreState createState() => _AppBarExploreState();
}

class _AppBarExploreState extends State<AppBarExplore> {
  late CoordinatesData coordinatesData = CoordinatesData(
    lat: 0,
    lng: 0, locationName: '',address: ''
  );
  LocationData? locationData;
  @override
  void initState() {
    // get current location
    _getCurrentLocation();

    super.initState();
  }

  void _getCurrentLocation() async {
    // get current location
    LocationData? locationData = await getCurrentLocation();

    //get name location
    String name  =
        await getAddress(locationData!.latitude!, locationData.longitude!);
    String address =
        await getLocationName(locationData.latitude!, locationData.longitude!);
    setState(() {
      coordinatesData.lat = locationData.latitude;
      coordinatesData.lng = locationData.longitude;
      coordinatesData.locationName = name;
      coordinatesData.address = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: ColorsGlobal.globalPink,
      toolbarHeight: AppSize.s80,
      // toolbarHeight: AppSize.s20,

      flexibleSpace: SafeArea(
        child: FlexibleSpaceBar(
          background: Image.asset(
            MediaRes.imgHome,
            fit: BoxFit.cover,
          ),
          expandedTitleScale: 1,
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                left: AppSize.s24,
                right: AppSize.s24,
                bottom: AppSize.s80,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_on,
                        color: ColorsGlobal.white,
                        size: AppSize.s17,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        coordinatesData.address, //hard code
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.location,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                left: AppSize.s24,
                right: AppSize.s24,
                child: SearchItemBar(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                ),
              ),
            ],
          ),
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.2,
      pinned: true,
      automaticallyImplyLeading: false,
    );
  }
}
