import 'dart:collection';
import 'package:template/pages/export.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splash:
      return _pageBuilder((_) => const SplashView(), settings: settings);

    case RouteName.login:
      return _pageBuilder((_) => const LoginView(), settings: settings);

    case RouteName.createAccount:
      return _pageBuilder((_) => const CreateAccountView(), settings: settings);

    case RouteName.otp:
      return _pageBuilder((_) => Otp(email: settings.arguments != null
              ? settings.arguments as String
              : null,),
          settings: settings);

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
      return _pageBuilder((_) => const CreateAccountView(), settings: settings);
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
