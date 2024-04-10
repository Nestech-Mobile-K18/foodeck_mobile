import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/resources/fonts.dart';
import 'package:template/resources/responsive.dart';
import 'package:template/resources/routes.dart';
import 'package:template/routes/router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
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
  }
}
