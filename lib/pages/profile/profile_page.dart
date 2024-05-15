import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:template/source/export.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Artboard? switchButton;
  SMIBool? isClick;

  List<ProfileButtons> kindSetting(
      KindSetting kindSetting, List<ProfileButtons> setting) {
    return setting
        .where((element) => element.kindSetting == kindSetting)
        .toList();
  }

  @override
  void initState() {
    rootBundle.load('assets/rives/switch_button_day&night.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artBoard, 'State Machine 1');
        if (controller != null) {
          artBoard.addController(controller);
          isClick = controller.findSMI('IsPressed');
        }
        setState(() => switchButton = artBoard);
      },
    );
    super.initState();
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Edit Account':
          Navigator.pushNamed(context, AppRouter.editAccount);
          break;
        case 'My locations':
          Navigator.pushNamed(context, AppRouter.myLocation);
          break;
        case 'My Orders':
          Navigator.pushNamed(context, AppRouter.myOrders);
          break;
        case 'Payment Methods':
          Navigator.pushNamed(context, AppRouter.paymentMethods);
          break;
        case 'My reviews':
          Navigator.pushNamed(context, AppRouter.myReviews);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: fullHeight * 0.35,
                color: dividerGrey,
                child: Padding(
                    padding: const EdgeInsets.only(top: 68),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          sharedPreferences.getString('avatar') != null
                              ? Container(
                                  height: 88,
                                  width: 88,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(sharedPreferences
                                              .getString('avatar')!),
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  width: 88,
                                  height: 88,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt),
                                      Text('No Image'),
                                    ],
                                  ),
                                ),
                          CustomText(
                              content: sharedPreferences.getString('name') ??
                                  'No name',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          currentAddress(
                              sharedPreferences.getString('currentAddress')!,
                              sharedPreferences.getString('currentAddress1')!),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 24, top: 40, bottom: 8),
                                    child: CustomText(
                                        content: 'Account Settings',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: globalPink))
                              ])
                        ])))),
            Column(
              children: [
                SizedBox(
                  height: fullHeight * 0.425,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
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
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                          kindSetting(KindSetting.account, profileButtons)
                                          .length -
                                      1 ==
                                  index
                              ? const SizedBox()
                              : Divider(color: Colors.grey.shade300)
                        ],
                      );
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    height: fullHeight * 0.09,
                    color: dividerGrey,
                    child: const Padding(
                        padding: EdgeInsets.only(left: 24, bottom: 8),
                        child: CustomText(
                            content: 'General Settings',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: globalPink))),
                SizedBox(
                  height: fullHeight * 0.17,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
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
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            CustomWidget.lightOrDarkAnimation(context),
            Padding(
                padding: const EdgeInsets.only(left: 12),
                child: TextButton.icon(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Are you sure want to logout?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  supabase.auth.signOut().then((value) =>
                                      Navigator.pushNamed(
                                          context, AppRouter.loginPage));
                                },
                                child: const CustomText(
                                    content: 'Yes', color: Colors.red)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const CustomText(
                                    content: 'No', color: Colors.blue))
                          ],
                        ),
                      );
                    },
                    label: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: CustomText(
                            content: 'Log Out', color: Colors.black)))),
            Container(
              height: fullHeight * 0.2,
              color: dividerGrey,
            )
          ],
        ),
      ),
    ));
  }
}
