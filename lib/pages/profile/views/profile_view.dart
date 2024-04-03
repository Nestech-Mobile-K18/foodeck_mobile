import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';
import 'package:template/resources/media_res.dart';
import 'package:template/widgets/custom_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsGlobal.globalWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    child: Image.asset(
                      MediaRes.avatar,
                      fit: BoxFit.cover,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                CustomText(title: 'title')
              ],
            )
          ],
        ),
      ),
    );
  }
}
