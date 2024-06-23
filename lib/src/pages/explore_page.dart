import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/features/cal_move_time/bloc/cal_move_time_bloc.dart';
import 'package:template/src/features/location/bloc/location_bloc.dart';
import 'package:template/src/features/restaurant/bloc/restaurant_bloc.dart';
import 'package:template/src/pages/export.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key, this.userData}) : super(key: key);
  final Map<dynamic, dynamic>? userData;

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // String? _userId = supabase.auth.currentSession?.user.email;
  // String? _type = supabase.auth.currentSession?.user.appMetadata['provider'];

  late TextEditingController _controller;
  late FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    // _userId = _userId ?? widget.userData?['email'];
    // _type = _type ?? widget.userData?['provider'];
    context
        .read<RestaurantBloc>()
        .add(RestaurantListStarted(locationBloc: context.read<LocationBloc>()));

    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Future<void> _handleRestaurant(
      {required int id,
      required String nameRestaurant,
      required String nameAddress,
      required double rate,
      required int time,
      required String timeUnit,
      required double distance,
      required String disUnit,
      String? image}) async {
    GoRouter.of(context).push(
      RouteName.restaurant,
      extra: {
        'id': id.toString(),
        'nameRestaurant': nameRestaurant,
        'nameAddress': nameAddress,
        'rate': rate.toString(),
        'time': time.toString(),
        'timeUnit': timeUnit,
        'distance': distance,
        'disUnit': disUnit,
        'image': image,
      },
    );

  }

  Future<void> _handleCart() async {
    Navigator.of(context).pushNamed(RouteName.cart);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            if (state is AuthenticationSuccess) {
                              // final userId = state.userId;
                              // final name = state.name;
                              // final pass = state.password;
                              // final avatar = state.avatar;

                              return Text('UserID: ${state.userInfor}');
                            }

                            // Handle other states or return a default widget if needed
                            return Text('Loading...');
                          },
                        ),
                        BlocBuilder<RestaurantBloc, RestaurantState>(
                          builder: (context, state) {
                            if (state is RestaurantListSuccess) {
                              return Text(
                                  'restaurant: ${state.restaurants![0].address!.name} ${state.restaurants!.length} ');
                            }

                            // Handle other states or return a default widget if needed
                            return Text('Loading...');
                          },
                        ),
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state is CurrentLocationSuccess) {
                              final address = state.address;
                              return Text(
                                address.toString(), //hard code
                                overflow: TextOverflow.ellipsis,
                              );
                            }

                            // Handle other states or return a default widget if needed
                            return Text('Loading...');
                          },
                        ),
                        // BlocBuilder<CalMoveTimeBloc, CalMoveTimeState>(
                        //   builder: (context, state) {
                        //     if (state is CalMoveTimeSuccess) {
                        //       return Text(
                        //           'restaurant: ${state.moveTime![0].time} ');
                        //     }

                        //     // Handle other states or return a default widget if needed
                        //     return Text('Loading...');
                        //   },
                        // ),
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

                  BlocBuilder<RestaurantBloc, RestaurantState>(
                    builder: (context, state) {
                      if (state is RestaurantListSuccess) {
                        return ListView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.restaurants!.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                  onTap: () => _handleRestaurant(
                                      id: state.restaurants![index].id,
                                      disUnit: state
                                          .restaurants![index].unitDistance,
                                      distance:
                                          state.restaurants![index].distance,
                                      nameAddress: state
                                          .restaurants![index].address!.name!,
                                      nameRestaurant:
                                          state.restaurants![index].name,
                                      rate: state.restaurants![index].rate,
                                      time: state.restaurants![index].time,
                                      timeUnit:
                                          state.restaurants![index].timeUnit,
                                      image: state.restaurants![index].image),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: AppPadding.p24),
                                    child: Item(
                                      id: state.restaurants![index].id,
                                      height: AppSize.s160,
                                      title: state.restaurants![index].name,
                                      address: state
                                          .restaurants![index].address!.name!,
                                      img: state.restaurants![index].image!,
                                      isLike: false,
                                      isMoney: false,
                                      rate: state.restaurants![index].rate,
                                      value: state.restaurants![index].time,
                                      unit: state.restaurants![index].timeUnit,
                                      isTypeTime: true,
                                    ),
                                    //  dealsHome[index],
                                  ));
                            });
                      }

                      // Handle other states or return a default widget if needed
                      return const CircularProgressIndicator();
                    },
                  ),

                  // ListView.builder(
                  //     physics:
                  //         const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     itemCount: dealsHome.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return InkWell(
                  //           onTap: () => _handleRestaurant(dealsHome[index].id),
                  //           child: Padding(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: AppPadding.p24),
                  //             child: dealsHome[index],
                  //           ));
                  //     }),

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
