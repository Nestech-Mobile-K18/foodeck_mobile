import 'dart:async';
import 'package:flutter/services.dart';
import 'package:template/pages/export.dart';

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
      body: CustomScrollView(
        slivers: [
          AppBarExplore(
            controller: _controller,
            focusNode: _focusNode,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // categories
                  Container(
                    width: MediaQuery.of(context).size.height - AppSize.s24 * 2,
                    padding: EdgeInsets.all(AppPadding.p24),
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
                              width: AppSize.s16,
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
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
                    child: Text(
                      AppStrings.deal,
                      style: AppTextStyle.titleHome,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
                    child: const CarouselWithIndicator(),
                  ),
                  //Deals
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p24, vertical: AppPadding.p12),
                    child: Text(
                      AppStrings.exploreMore,
                      style: AppTextStyle.titleHome,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p24),
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
                  //           colorLabel: ColorsGlobal.white,
                  //           width: AppSize.s328,
                  //           height: AppSize.s62,
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
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _handleCart(),
        backgroundColor: ColorsGlobal.globalPink,
        child: const Icon(
          Icons.shopping_cart,
          color: ColorsGlobal.white,
        ),
      ),
    );
  }
}
