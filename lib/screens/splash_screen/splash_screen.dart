import 'package:flutter/material.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //
  @override
  void initState() {
    super.initState();
    _goLoginScreen();
  }

  void _goLoginScreen() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      },
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppImage.splashScreen,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: CircularProgressIndicator(
        backgroundColor: AppColor.grey6,
        color: AppColor.yellow,
        value: 0.5,
      ),
    );
  }
}
