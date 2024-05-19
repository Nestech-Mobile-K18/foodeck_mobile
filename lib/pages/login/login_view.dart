import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:template/pages/export.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final StreamSubscription<AuthState> _authStateSubscription;
  late Map<dynamic, dynamic> _userData = {};
  bool _isLogin = false;
  // final ErrorDialog showError = ErrorDialog();

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      print('seession: $session');
      if (_isLogin) return;

      if (session != null) {
        _isLogin = true;
        Navigator.of(context).pushReplacementNamed('/home', arguments: null);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  Future<void> setLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
  }

  Future<void> handleSuccessfulLogin() async {
    await setLoggedIn(true);
  }

  Future<void> loginWithGoogle() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      // La Android hoac IOS
      const webClientId =
          '915077099112-c8i6upjieoerckc59so2tftq18kjit2d.apps.googleusercontent.com';
      const iosClientId =
          '915077099112-bs6c6v77sttmf9h7uqq10httd9mujs2q.apps.googleusercontent.com';

      // Google sign in on Android will work without providing the Android
      // Client ID registered on Google Cloud.

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

      try {
        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );

        if (mounted) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Login success'),
                backgroundColor: ColorsGlobal.green));
          }
        }
      } on AuthException catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      } catch (error) {
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Unexpected error occurred'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ));
      }
    } else {
      // TH la web
      await supabase.auth.signInWithOAuth(OAuthProvider.google);
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      // Create an instance of FacebookLogin
      final result = await FacebookAuth.i
          .login(permissions: ['email', 'public_profile']).then((value) => {
                FacebookAuth.i
                    .getUserData(fields: "email, name")
                    .then((userData) async {
                  setState(() {
                    // luu thong tin user FB login
                    _isLogin = true;
                    _userData = {...userData, 'provider': 'facebook'};
                    print('user login: $userData');
                    Navigator.of(context)
                        .pushNamed(RouteName.home, arguments: _userData);
                  });
                })
              });
    } catch (e) {
      print(e);
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  Future<void> signInWithEmail() async {
    Navigator.of(context).pushNamed(RouteName.loginEmail);
  }

  Future<void> handleSignUp() async {
    Navigator.of(context).pushNamed(RouteName.signup);
  }

  Future<void> signInWithApple() async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The feature is being developed'),
        backgroundColor: ColorsGlobal.blue2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(MediaRes.imgLogin),
            fit: BoxFit.cover,
          ),
          backgroundColor: ColorsGlobal.transparent,
          toolbarHeight: AppSize.s295,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                AppPadding.p32, AppPadding.p48, AppPadding.p32, AppPadding.p32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                      label: AppStrings.loginGoogle,
                      colorBackgroud: ColorsGlobal.red,
                      colorLabel: ColorsGlobal.white,
                      icon: MediaRes.icGoogle,
                      width: AppSize.s328,
                      height: AppSize.s62,
                      onPressed: () => loginWithGoogle()),
                  Button(
                      label: AppStrings.loginFacebook,
                      colorBackgroud: ColorsGlobal.blue,
                      colorLabel: ColorsGlobal.white,
                      icon: MediaRes.icFacebook,
                      width: AppSize.s328,
                      height: AppSize.s62,
                      onPressed: () => signInWithFacebook()),
                  Button(
                      label: AppStrings.loginApple,
                      colorBackgroud: ColorsGlobal.black,
                      colorLabel: ColorsGlobal.white,
                      icon: MediaRes.icApple,
                      width: AppSize.s328,
                      height: AppSize.s62,
                      onPressed: () => signInWithApple()),
                  Button(
                      label: AppStrings.email,
                      colorLabel: ColorsGlobal.white,
                      colorBackgroud: ColorsGlobal.globalPink,
                      icon: MediaRes.icMail,
                      width: AppSize.s328,
                      height: AppSize.s62,
                      onPressed: () => signInWithEmail()),
                  Button(
                      label: AppStrings.createAccount,
                      colorLabel: ColorsGlobal.grey,
                      colorBorder: ColorsGlobal.grey,
                      colorBackgroud: ColorsGlobal.white,
                      width: AppSize.s328,
                      height: AppSize.s62,
                      onPressed: () => handleSignUp()),
                  Padding(
                    padding: EdgeInsets.only(top: AppPadding.p32),
                    child: Text(
                      AppStrings.bySigningUp,
                      style: AppTextStyle.decription,
                    ),
                  )
                ]),
          ),
        ));
  }
}
