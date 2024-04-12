import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/pages/profile/widget/avatar.dart';
import 'package:template/pages/profile/widget/edit_account.dart';
import 'package:template/values/colors.dart';
import 'package:template/values/list.dart';
import 'package:template/values/text_styles.dart';

import '../../main.dart';

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

  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _getInitialProfile();
  }

  Future<void> _getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      _imageUrl = data['avatar_url'];
    });
  }

  void editAccount() {
    Get.to(() => EditAccount());
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Edit Account':
          editAccount();
          break;
        case 'My locations':
          break;
        case 'My Orders':
          break;
        case 'Payment Methods':
          break;
        case 'My reviews':
          break;
        case 'About us':
          break;
        case 'Data usage':
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
      height: fullHeight,
      width: fullWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: fullHeight * 0.35,
              color: dividerGrey,
              child: Padding(
                padding: const EdgeInsets.only(top: 68),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Avatar(
                        imageUrl: _imageUrl,
                        onUpload: (imageUrl) async {
                          setState(() {
                            _imageUrl = imageUrl;
                          });
                          final userId = supabase.auth.currentUser!.id;
                          await supabase.from('profiles').update(
                              {'avatar_url': imageUrl}).eq('id', userId);
                        }),
                    Text(
                      'John Doe',
                      style: inter.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lahore, Pakistan',
                      style: inter.copyWith(fontSize: 15, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 40, bottom: 8),
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
            Column(
              children: [
                SizedBox(
                  height: fullHeight * 0.425,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        kindSetting(KindSetting.account, profileButtons).length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                check(profileButtons[index].info);
                              },
                              child: ListTile(
                                title: Text(kindSetting(KindSetting.account,
                                        profileButtons)[index]
                                    .info),
                                leading: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(kindSetting(
                                                    KindSetting.account,
                                                    profileButtons)[index]
                                                .icon),
                                            fit: BoxFit.cover))),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                          kindSetting(KindSetting.account, profileButtons)
                                          .length -
                                      1 ==
                                  index
                              ? SizedBox()
                              : Divider(
                                  color: Colors.grey.shade300,
                                )
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  height: fullHeight * 0.09,
                  color: dividerGrey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: Text('General Settings',
                        style: inter.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: globalPink)),
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.17,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        kindSetting(KindSetting.general, profileButtons).length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListTile(
                              title: Text(kindSetting(KindSetting.general,
                                      profileButtons)[index]
                                  .info),
                              leading: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(kindSetting(
                                                  KindSetting.general,
                                                  profileButtons)[index]
                                              .icon),
                                          fit: BoxFit.cover))),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                        kindSetting(KindSetting.general, profileButtons)
                                        .length -
                                    1 ==
                                index
                            ? SizedBox()
                            : Divider(
                                color: Colors.grey.shade300,
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: fullHeight * 0.2,
              color: dividerGrey,
            )
            // ElevatedButton(
            //     onPressed: () {
            //       supabase.auth.signOut();
            //     },
            //     child: Text('data'))
          ],
        ),
      ),
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
