import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    _userId = _userId ?? widget.userData?['email'];
    _type = _type ?? widget.userData?['provider'];

    print('user Data: ${widget.userData}');
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((event) {
      _userId = event.session?.user.email ?? widget.userData?['email'];

      if (_userId == null) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('/login');
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

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _authStateSubscription.cancel();
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
                        child: Category(
                          height: 160.dp,
                          title: 'Food',
                          decription: 'Order food you love',
                          img: MediaRes.img1,
                          bottom: 16.dp,
                        ),
                      ),
                    ],
                  ),
                  IntrinsicHeight(
                    //IntrinsicHeight đảm bảo các item trong cùng dòng có cùng chiều cao
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Category(
                            height: 160.dp,
                            title: 'Grocery',
                            decription: 'Shop daily life items',
                            img: MediaRes.img3,
                            right: 8.dp,
                          ),
                        ),
                        SizedBox(
                          width: 16.dp,
                        ),
                        Expanded(
                          flex: 1,
                          child: Category(
                            height: 160.dp,
                            title: 'Deserts',
                            decription: 'Something Sweet',
                            img: MediaRes.img2,
                            left: 8.dp,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            // list sale
            Padding(
              padding: EdgeInsets.only(top: 48.dp, bottom: 60.dp),
              child: const CarouselWithIndicator(),
            ),

            //Deals 
            Item(
              height: 160.dp,
              width: 320.dp,
              title: 'Pizza',
              shopName: 'ABC s1133',
              img: MediaRes.img4,
              isLike: false,
              isMoney: false,
              rate: 3.0,
              value: '40',
              unit: 'min',
            ),
          ],
        ),
      ),
    );

    // return Container(
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
    // );
  }
}