import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/button.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_userId ?? 'Not sign in'),
          Button(
              label: 'LogOut',
              colorBackgroud: ColorsGlobal.red,
              colorLabel: Colors.white,
              width: 328,
              height: 62,
              onPressed: () async {
                if (_type == 'facebook') {
                  print('logout FB');
                  await FacebookLogin().logOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('/login');
                } // TH login with Gooogle
                else {
                  print('logout gmail gg');

                  var isSignedIn = await GoogleSignIn().isSignedIn();
                  if (isSignedIn) await GoogleSignIn().signOut();
                }

                // TH login with Facebook
                await supabase.auth.signOut();
              }),
        ],
      ),
    );
  }
}
