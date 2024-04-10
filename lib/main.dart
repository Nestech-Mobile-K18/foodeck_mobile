import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/services/supabase/supabase_config.dart';
import 'package:device_preview/device_preview.dart';
import 'app.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: ((context) => const MyApp()),
  ));
}
