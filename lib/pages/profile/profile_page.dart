import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/main.dart';
import 'package:template/pages/login/login_page.dart';

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
        child: ElevatedButton(
            onPressed: () {
              supabase.auth
                  .signOut()
                  .then((value) => Get.to(() => LoginPage()));
            },
            child: Text('Logout')),
      ),
    );
  }
}
