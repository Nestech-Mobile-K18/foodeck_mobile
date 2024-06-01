import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/services/supabase/supabase_config.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';
import 'package:appcenter_sdk_flutter/appcenter_sdk_flutter.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppCenter.start(secret: "c8970c62-56fb-4e15-9323-c7202a3690a8");
  FlutterError.onError = (final details) async {
    await AppCenterCrashes.trackException(
      message: details.exception.toString(),
      type: details.exception.runtimeType,
      stackTrace: details.stack,
    );
  };
  runApp(DevicePreview(
    enabled: false,
    builder: ((context) => const MyApp()),
  ));
}
