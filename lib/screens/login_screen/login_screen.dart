import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:foodeck_app/widgets/custom_login_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;

  //
  Future<void> _loginViaGoogle() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '806593757409-p42scmr28pv17fuer4f952mvvtum9f14.apps.googleusercontent.com';

    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '806593757409-58kekmrg0gphr7om5lsguemkjifab6lv.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      setState(() {
        if (event == AuthChangeEvent.signedIn) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HomeScreen(page: 0)));
        } else {
          Navigator.pop(context);
        }
      });
    });
  }

  //
  Future<void> _loginViaFacbook() async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        // final profile = await fb.getUserProfile();
        final email = await fb.getUserEmail();
        // final imageUrl = await fb.getProfileImageUrl(width: 100);

        if (accessToken == null) {
          throw 'No Access Token found.';
        }
        if (email == null) {
          throw 'No email found.';
        }

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        throw ('Error while log in: ${res.error}');
    }
  }

  //
  void _loginViaApple() {}
  //
  void _loginViaEmail() {
    setState(() {
      Navigator.pushNamed(context, AppRoutes.loginViaEmail);
    });
  }

  //
  void _createAnAccount() {
    setState(() {
      Navigator.pushNamed(context, AppRoutes.createAccount);
    });
  }
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 295),
        child: Image.asset(
          AppImage.loginBackground,
          fit: BoxFit.cover,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(
            height: 44,
            color: Colors.transparent,
          ),
          SizedBox(
            width: 328,
            height: 78 * 5,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Column(
                children: [
                  CustomLoginButton(
                    customLoginButtonsInfo: customLoginButtonsInfo[index],
                    onPressed: customLoginButtonsInfo[index] ==
                            customLoginButtonsInfo[0]
                        ? () async {
                            _loginViaGoogle();
                          }
                        : customLoginButtonsInfo[index] ==
                                customLoginButtonsInfo[1]
                            ? () {
                                _loginViaFacbook();
                              }
                            : customLoginButtonsInfo[index] ==
                                    customLoginButtonsInfo[2]
                                ? _loginViaApple
                                : customLoginButtonsInfo[index] ==
                                        customLoginButtonsInfo[3]
                                    ? _loginViaEmail
                                    : customLoginButtonsInfo[index] ==
                                            customLoginButtonsInfo[4]
                                        ? _createAnAccount
                                        : null,
                  ),
                  const Divider(
                    height: 16,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 8,
            color: Colors.transparent,
          ),
          SizedBox(
            width: 328,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "By signing up, you are agreeing to our ",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.justify,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Terms &",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Conditions",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
