import 'package:flutter/material.dart';
import 'package:template/services/supabase/supabase_config.dart';

import 'app.dart';

void main() async {
  SupabaseConfig().initializeSupabase();
  runApp(const MyApp());
}
