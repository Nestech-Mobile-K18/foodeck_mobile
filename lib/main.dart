import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/screens/login_screen/login_screen.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/payment_method_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'].toString(),
    anonKey: dotenv.env['SUPABASE_ANON_KEY'].toString(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PaymentMethodScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.paymentMethodScreen,
      routes: AppRoutes.routes,
    );
  }
}
