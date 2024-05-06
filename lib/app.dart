import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
import 'package:template/pages/export.dart';
import 'package:template/resources/fonts.dart';
// import 'package:template/resources/routes.dart';
import 'package:template/routes/router.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    // DeviceOrientation.portraitUp,
    //     // DeviceOrientation.portraitDown,
    //   ]);
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          // không cho thay đổi size chữ khi thiết bị thay đổi
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
              ),
              child: child!,
            );
          },
          // builder: DevicePreview.appBuilder,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
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
