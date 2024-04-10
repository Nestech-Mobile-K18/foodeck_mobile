import 'package:flutter/material.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/images.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ProfileButtons> kindSetting(
      KindSetting kindSetting, List<ProfileButtons> setting) {
    return setting
        .where((element) => element.kindSetting == kindSetting)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 290,
          width: double.infinity,
          color: dividerGrey,
          child: Padding(
            padding: const EdgeInsets.only(top: 68),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(avatar), fit: BoxFit.cover),
                        color: Colors.grey)),
                Text(
                  'John Doe',
                  style:
                      inter.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Lahore, Pakistan',
                  style: inter.copyWith(fontSize: 15, color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 40),
                      child: Text(
                        'Account Settings',
                        style: inter.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: globalPink),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 290,
          width: double.infinity,
          child: ListView.builder(
            itemCount: kindSetting(KindSetting.account, profileButtons).length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(profileButtons[index].info),
                leading: Image.asset(userCircle),
              );
            },
          ),
        )
      ],
    ));
  }
}
// Center(
// child: Column(
// children: [
// ElevatedButton(
// onPressed: () {
// supabase.auth
//     .signOut()
//     .then((value) => Get.to(() => LoginPage()));
// },
// child: Text('Logout')),
// Switch.adaptive(
// value:
// Provider.of<ThemeProvider>(context, listen: true).isDarkMode,
// onChanged: (value) =>
// Provider.of<ThemeProvider>(context, listen: false)
//     .toggleTheme(),
// )
// ],
// ),
// ),
