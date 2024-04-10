import 'package:template/pages/application/views/application_view.dart';
import 'package:template/pages/home/view/home_view.dart';
import 'package:template/pages/map/views/map_view.dart';

import '../pages/forgot_password/views/forgot_password_view.dart';
import '../pages/forgot_password/views/new_password_view.dart';
import '../resources/routes.dart';
import '../pages/otp/views/otp_view.dart';
import 'package:flutter/material.dart';
import '../pages/login/views/login_view.dart';
import '../pages/splash/splash_view.dart';
import '../common/view/page_under_construction.dart';
import '../pages/create_account/views/create_account_view.dart';

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

    case RouteName.forgotPassword:
      return _pageBuilder((_) => const ForgotPasswordView(),
          settings: settings);
    case RouteName.newPassword:
      return _pageBuilder((_) => const NewPasswordView(), settings: settings);
    case RouteName.home:
      return _pageBuilder((_) => const HomeView(), settings: settings);
    case RouteName.application:
      return _pageBuilder((_) => const ApplicationView(), settings: settings);

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
