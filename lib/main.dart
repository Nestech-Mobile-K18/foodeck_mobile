import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/services/supabase/supabase_config.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(DevicePreview(
    enabled: false,
    builder: ((context) => const MyApp()),
  ));
}
