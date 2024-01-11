import 'package:flutter/material.dart';
import 'package:template/common/view/page_under_construction.dart';
import 'package:template/pages/login/login_view.dart';

import '../pages/splash/splash_view.dart';
import '../resources/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splash:
      return _pageBuilder((_) => SplashView(), settings: settings);

    case RouteName.login:
      return _pageBuilder((_) => LoginView(), settings: settings);

    default:
      return _pageBuilder((_) => PageUnderConstruction(), settings: settings);
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
