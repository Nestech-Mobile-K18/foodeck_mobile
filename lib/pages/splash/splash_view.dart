import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:template/pages/login/login_view.dart';
import 'package:template/resources/export.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 2000),
      nextScreen: const LoginView(),
      backgroundColor: Colors.white,
      splashScreenBody: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            MediaRes.backgroundSplash,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
