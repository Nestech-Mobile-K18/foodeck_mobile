import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

// void main() {
//   runApp(const MyApp());
// }


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://awcdjjsmxiysdbbersaf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF3Y2RqanNteGl5c2RiYmVyc2FmIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcxMTQ2OTM0OSwiZXhwIjoyMDI3MDQ1MzQ5fQ.aZA7bwES50K7LEY7epKYZhbMV0YlDzLR5ZhZw6K1Cu4',
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;