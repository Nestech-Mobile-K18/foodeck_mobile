import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override

  /*
  void initState() {
    super.initState();
    startCountDown();
  }

  void startCountDown() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, commonValue.login);
    });
  }

   */

  Widget build(BuildContext context) {
    return Scaffold(
      body: /* Center(
        child: Stack(
          children: [
            Container(
              child: Image.asset(
                'assets/images/Splash_Screen.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              child: Center(
                child: Image.asset('assets/images/splash_logo.png'),
              ),
            ),
          ],
        ),
      ),

      */

          FlutterSplashScreen.fadeIn(
        backgroundImage: Image.asset('assets/images/Splash_Screen.png'),
        childWidget: Container(
          padding: EdgeInsets.fromLTRB(24, 158, 24, 430),
          child: SizedBox(
            height: 273,
            width: 328,
            child: Image.asset("assets/images/splash_logo.png"),
          ),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen: const LoginScreen(),
        animationCurve: Easing.standard,
        setStateTimer: Durations.extralong4,
      ),
    );
  }
}
