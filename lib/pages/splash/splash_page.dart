import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/pages/home/home_page.dart';
import 'package:template/pages/login/login_page.dart';
import 'package:template/values/images.dart';
import 'package:template/values/text_styles.dart';
import 'package:template/widgets/loading_animation.dart';

import '../../main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool show = true;
  bool showLoading = true;
  bool showFinish = false;

  late final StreamSubscription<AuthState> authSubscription;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  Future startAnimation() async {
    await Future(() {
      setState(() {
        show = !show;
      });
    });
    await Future.delayed(
      const Duration(milliseconds: 2500),
      () {
        setState(() {
          showLoading = !showLoading;
        });
      },
    );
    await Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        showFinish = !showFinish;
      });
    });
    await Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        show = !show;
      });
    });
    await Future.delayed(
      const Duration(milliseconds: 4000),
      () {
        authSubscription = supabase.auth.onAuthStateChange.listen((event) {
          final session = event.session;
          if (session != null) {
            Get.to(() => const HomePage(),
                transition: Transition.zoom,
                duration: const Duration(milliseconds: 1000));
          } else if (session == null) {
            Get.to(() => const LoginPage(),
                transition: Transition.zoom,
                duration: const Duration(milliseconds: 1000));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
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
                  child: Text('Foodeck',
                      style: inter.copyWith(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))),
              AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  top: show ? 800 : 387,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Aliquam commodo tortor lacinia lorem\naccumsan aliquam',
                    style: inter.copyWith(fontSize: 17, color: Colors.white),
                  )),
              Positioned(
                top: showFinish ? 450 : 500,
                child: showFinish
                    ? SizedBox(
                        // height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: show ? null : Lottie.asset(loading))
                    : AnimatedOpacity(
                        opacity: showLoading ? 0 : 1,
                        duration: const Duration(seconds: 2),
                        child: const WaveDots(size: 36, color: Colors.white)),
              )
            ],
          )),
    );
  }
}
