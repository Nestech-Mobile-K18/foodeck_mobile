import 'dart:async';
import 'package:flutter/services.dart';
import 'package:template/pages/export.dart';
import 'package:template/pages/restaurant/restaurant_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.userData});
  final Map<dynamic, dynamic>? userData;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamSubscription<AuthState> _authStateSubscription;

  String? _userId = supabase.auth.currentSession?.user.email;
  String? _type = supabase.auth.currentSession?.user.appMetadata['provider'];

  late TextEditingController _controller;
  late FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _userId = _userId ?? widget.userData?['email'];
    _type = _type ?? widget.userData?['provider'];

    // print('user Data: ${widget.userData}');
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((event) {
      _userId = event.session?.user.email ?? widget.userData?['email'];

      if (_userId == null) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed(RouteName.login);
      }
    });

    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Future<void> _handleRestaurant(String id) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RestaurantView(id: id),
          settings: RouteSettings(name: RouteName.restaurant, arguments: id)),
    );
  }

  Future<void> _handleCart() async {
    Navigator.of(context).pushNamed(RouteName.cart);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _authStateSubscription.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(168.dp),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Image(
              image: AssetImage(MediaRes.imgHome),
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 24.dp,
              right: 24.dp,
              bottom: 80.dp,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 17.dp,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Block B Phase 2 Johar Town, Lahore', //hard code
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 22.dp, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 16,
              left: 24.dp,
              right: 24.dp,
              child: SearchItemBar(
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // categories
            Container(
              width: MediaQuery.of(context).size.height - 24.dp * 2,
              padding: EdgeInsets.all(24.dp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: catefories[0],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: catefories[1],
                      ),
                      SizedBox(
                        width: 16.dp,
                      ),
                      Expanded(
                        flex: 1,
                        child: catefories[2],
                      )
                    ],
                  )
                ],
              ),
            ),

            // list deal
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp),
              child: Text(
                'Deal',
                style: TextStyle(fontSize: 22.dp, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.dp),
              child: const CarouselWithIndicator(),
            ),
            //Deals
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.dp, vertical: 12.dp),
              child: Text(
                'Explore More',
                style: TextStyle(fontSize: 22.dp, fontWeight: FontWeight.w800),
              ),
            ),

            ListView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: dealsHome.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () => _handleRestaurant(dealsHome[index].id),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.dp),
                        child: dealsHome[index],
                      ));
                }),

            // logout
            // Container(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(_userId ?? 'Not sign in'),
            //       Button(
            //           label: 'LogOut',
            //           colorBackgroud: ColorsGlobal.red,
            //           colorLabel: Colors.white,
            //           width: 328.dp,
            //           height: 62.dp,
            //           onPressed: () async {
            //             if (_type == 'facebook') {
            //               print('logout FB');
            //               await FacebookLogin().logOut();
            //               // ignore: use_build_context_synchronously
            //               Navigator.of(context, rootNavigator: true)
            //                   .pushReplacementNamed('/login');
            //             } // TH login with Gooogle
            //             else {
            //               print('logout gmail gg');
            //               var isSignedIn = await GoogleSignIn().isSignedIn();
            //               if (isSignedIn) await GoogleSignIn().signOut();
            //             }

            //             // TH login with Facebook
            //             await supabase.auth.signOut();
            //           }),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _handleCart(),
        backgroundColor: ColorsGlobal.globalPink,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
