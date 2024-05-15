import 'package:template/source/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '5627539322-gr1o01gg983mhdq7320tsnecgq0a35m4.apps.googleusercontent.com';

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    // const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
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

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future facebookSignIn() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Login via Email':
          Navigator.pushNamed(context, AppRouter.loginOrRegister,
              arguments: const LoginOrRegister(index: 0));
          break;
        case 'Create an account':
          Navigator.pushNamed(context, AppRouter.loginOrRegister,
              arguments: const LoginOrRegister(index: 1));
          break;
        case 'Login via Google':
          _googleSignIn();
          break;
        case 'Login via Facebook':
          facebookSignIn();
          break;
        case 'Login via Apple':
          ShowBearSnackBar.showBearSnackBar(context, 'Updating...');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:
                      Image.asset(Assets.loginBackGround, fit: BoxFit.cover))),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: loginButton.length,
                        itemBuilder: (context, index) {
                          return CustomButton(
                            onPressed: () {
                              check(loginButton[index].loginText);
                            },
                            borderSide: index == loginButton.length - 1
                                ? const BorderSide(color: Colors.grey)
                                : null,
                            icons: index == loginButton.length - 1
                                ? null
                                : Image.asset(loginButton[index].type),
                            text: CustomText(
                                content: loginButton[index].loginText,
                                color: index == loginButton.length - 1
                                    ? Colors.grey
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                            color: loginButton[index].backGroundColor,
                          );
                        },
                      ),
                    ),
                    const Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          CustomText(
                              content: 'By signing up, you are agreeing to our',
                              fontSize: 13,
                              color: Colors.grey),
                          CustomText(
                              content: 'Terms & Conditions',
                              fontSize: 13,
                              color: globalPink)
                        ]))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
