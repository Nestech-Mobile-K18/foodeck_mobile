import 'package:flutter/material.dart';
import 'package:template/routes/common.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startCountDown();
  }

  void startCountDown() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, commonValue.login);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/images/Splash_Screen.png'),
        ),
        Container(
          child: Center(
            child: Image.asset('assets/images/splash_logo.png'),
          ),
        ),
      ],
    ));
  }
}
