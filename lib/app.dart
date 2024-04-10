import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:template/pages/home/home_page.dart';
import 'package:template/pages/login/login_page.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/pages/splash/splash_page.dart';
import 'package:template/values/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            // theme: Provider.of<ThemeProvider>(context).themeData,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            defaultTransition: Transition.rightToLeft,
            transitionDuration: const Duration(milliseconds: 600),
            debugShowCheckedModeBanner: false,
            initialRoute: splashPage,
            routes: {
              splashPage: (context) => const SplashPage(),
              createAccount: (context) => const CreateAccount(),
              loginEmail: (context) => const LoginEmail(),
              loginPage: (context) => const LoginPage(),
              homePage: (context) => const HomePage()
            });
      },
    );
  }
}
