import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/services/supabase/supabase_config.dart';

import 'app.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}
