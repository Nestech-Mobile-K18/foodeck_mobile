import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/pages/login/login_page.dart';
import 'package:template/values/images.dart';
import 'package:template/widgets/loading_animation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool show = true;
  bool showLoading = true;

  @override
  void initState() {
    start();
    loadingAnimation();
    navigateToHome();
    super.initState();
  }

  void start() {
    Future.delayed(const Duration(milliseconds: 0), () {
      setState(() {
        show = !show;
      });
    });
  }

  void loadingAnimation() {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        setState(() {
          showLoading = !showLoading;
        });
      },
    );
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 7000),
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            show = !show;
          });
        },
        child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: show
                    ? null
                    : const DecorationImage(
                        image: AssetImage(splashScreen), fit: BoxFit.cover)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                    duration: const Duration(seconds: 2),
                    top: show ? 0 : 170,
                    child: Image.asset(foodDeck)),
                AnimatedPositioned(
                    duration: const Duration(seconds: 2),
                    top: 290,
                    left: show ? 0 : 92,
                    child: const Text(
                      'Foodeck',
                      style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                AnimatedPositioned(
                    duration: const Duration(seconds: 2),
                    top: show ? 800 : 387,
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Aliquam commodo tortor lacinia lorem\naccumsan aliquam',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    )),
                Positioned(
                  top: 500,
                  child: AnimatedOpacity(
                      opacity: showLoading ? 0 : 1,
                      duration: const Duration(seconds: 2),
                      child: const WaveDots(size: 36, color: Colors.white)),
                )
              ],
            )),
      ),
    );
  }
}
