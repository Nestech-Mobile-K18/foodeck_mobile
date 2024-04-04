import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:template/main.dart';
import 'package:template/pages/login/login_page.dart';
import 'package:template/themes/theme_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  supabase.auth
                      .signOut()
                      .then((value) => Get.to(() => LoginPage()));
                },
                child: Text('Logout')),
            Switch.adaptive(
              value:
                  Provider.of<ThemeProvider>(context, listen: true).isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
