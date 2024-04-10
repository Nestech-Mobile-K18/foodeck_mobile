import 'package:device_preview/device_preview.dart';
import 'package:template/pages/export.dart';
import 'package:template/resources/fonts.dart';
import 'package:template/routes/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'My App',
          theme: ThemeData(
            useMaterial3: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: Fonts.inter,
            appBarTheme: const AppBarTheme(color: Colors.transparent),
          ),
          onGenerateRoute: generateRoute,
          initialRoute: RouteName.splash,
        );
      },
    );
  }
}
