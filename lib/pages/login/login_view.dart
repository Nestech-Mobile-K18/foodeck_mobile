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
                content: Text('Login success'), backgroundColor: Colors.green));
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
        backgroundColor: Colors.blue));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage(MediaRes.imgLogin),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 295.dp,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(32.dp, 48.dp, 32.dp, 32.dp),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                      label: 'Login via Google',
                      colorBackgroud: ColorsGlobal.red,
                      colorLabel: Colors.white,
                      icon: MediaRes.icGoogle,
                      width: 328.dp,
                      height: 62.dp,
                      onPressed: () => loginWithGoogle()),
                  Button(
                      label: 'Login via Facebook',
                      colorBackgroud: ColorsGlobal.blue,
                      colorLabel: Colors.white,
                      icon: MediaRes.icFacebook,
                      width: 328.dp,
                      height: 62.dp,
                      onPressed: () => signInWithFacebook()),
                  Button(
                      label: 'Login via Apple',
                      colorBackgroud: ColorsGlobal.black,
                      colorLabel: Colors.white,
                      icon: MediaRes.icApple,
                      width: 328.dp,
                      height: 62.dp,
                      onPressed: () => signInWithApple()),
                  Button(
                      label: 'Login via Email',
                      colorLabel: Colors.white,
                      colorBackgroud: ColorsGlobal.globalPink,
                      icon: MediaRes.icMail,
                      width: 328.dp,
                      height: 62.dp,
                      onPressed: () => signInWithEmail()),
                  Button(
                      label: 'Create an account',
                      colorLabel: ColorsGlobal.grey,
                      colorBorder: ColorsGlobal.grey,
                      colorBackgroud: Colors.white,
                      width: 328.dp,
                      height: 62.dp,
                      onPressed: () => handleSignUp()),
                  Padding(
                    padding: EdgeInsets.only(top: 32.0.dp),
                    child: Text(
                      'By signing up, you are agreeing to our Terms & Conditions',
                      style:
                          TextStyle(color: ColorsGlobal.grey, fontSize: 18.dp),
                    ),
                  )
                ]),
          ),
        ));
  }
}
