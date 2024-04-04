import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/models/restaurant.dart';
import 'package:template/pages/home/home_page.dart';
import 'package:template/pages/login/login_page.dart';
import 'package:template/pages/login/widgets/create_account.dart';
import 'package:template/pages/login/widgets/login_email.dart';
import 'package:template/pages/splash/splash_page.dart';
import 'package:template/themes/theme_provider.dart';
import 'package:template/values/route.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: dotenv.env['URL'].toString(),
      anonKey: dotenv.env['ANONKEY'].toString());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Restaurant(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
            theme: Provider.of<ThemeProvider>(context).themeData,
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

final supabase = Supabase.instance.client;
final data = supabase.from('banners').stream(primaryKey: ['id']);
RegExp emailRegex = RegExp(
    r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
RegExp passRegex = RegExp(
    r'^(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$');
