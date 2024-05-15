import 'package:template/source/export.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String _currentAddress = '';
  String _currentAddress1 = '';

  @override
  void initState() {
    setAddress();
    super.initState();
  }

  void setAddress() async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        getLatLngFromSharedPrefs().latitude,
        getLatLngFromSharedPrefs().longitude);
    Placemark place = placeMarks[0];
    setState(() {
      // Convert latitude and longitude to address
      _currentAddress = '${place.street}, ${place.subAdministrativeArea}';
      _currentAddress1 = '${place.administrativeArea}, ${place.country}';
      sharedPreferences.setString('currentAddress', _currentAddress);
      sharedPreferences.setString('currentAddress1', _currentAddress1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus;
      },
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Assets.homeBar,
                fit: BoxFit.cover,
              )),
          toolbarHeight: 142,
          automaticallyImplyLeading: false,
          titleTextStyle:
              AppText.inter.copyWith(fontSize: 17, color: Colors.white),
          titleSpacing: 24,
          title: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  currentAddress(sharedPreferences.getString('currentAddress')!,
                      sharedPreferences.getString('currentAddress1')!),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.searchPage),
                    child: Container(
                        height: 54,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(4, 4),
                                  blurRadius: 5,
                                  spreadRadius: 1),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            children: [
                              Image.asset(Assets.search, color: Colors.grey),
                              Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CustomText(
                                      content: 'Search...',
                                      color: Colors.grey[400]))
                            ],
                          ),
                        )),
                  ))
            ],
          ),
        ),
        body: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: TopListShopping(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: ListSlideBanner(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: MiddleSlideList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                child: BottomListShopping(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
