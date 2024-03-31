import 'dart:collection';

import 'package:template/pages/home/home_view.dart';
import 'package:template/pages/login/widgets/sign_up.dart';
import 'package:template/pages/login/widgets/login_email_view.dart';
import 'package:template/pages/map/map_view.dart';

import '../resources/routes.dart';
import '../pages/otp/otp_view.dart';
import 'package:flutter/material.dart';
import '../pages/login/login_view.dart';
import '../pages/splash/splash_view.dart';
import '../common/view/page_under_construction.dart';
import '../pages/create_account/create_account_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splash:
      return _pageBuilder((_) => const SplashView(), settings: settings);

    case RouteName.login:
      return _pageBuilder((_) => const LoginView(), settings: settings);

    case RouteName.createAccount:
      return _pageBuilder((_) => const CreateAccountView(), settings: settings);

    case RouteName.otp:
      return _pageBuilder((_) => const OtpView(), settings: settings);

    case RouteName.map:
      return _pageBuilder((_) => const MapBoxView(), settings: settings);

    case RouteName.home:
      return _pageBuilder(
        (_) => HomePage(
          userData: settings.arguments != null
              ? settings.arguments as Map<dynamic, dynamic>
              : null,
        ),
        settings: settings,
      );
    case RouteName.loginEmail:
      return _pageBuilder((_) => const LoginEmailView(), settings: settings);
    case RouteName.signup:
      return _pageBuilder((_) => const SignUp(), settings: settings);
    default:
      return _pageBuilder((_) => const PageUnderConstruction(),
          settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(Widget Function(BuildContext) page,
    {required RouteSettings settings}) {
  return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, _, __) => page(context));
}
