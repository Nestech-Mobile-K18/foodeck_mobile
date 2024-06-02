import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool change = false;

  List<RiveModel> kindSetting(
      KindSetting kindSetting, List<RiveModel> setting) {
    return setting
        .where((element) => element.kindSetting == kindSetting)
        .toList();
  }

  void check(String index) {
    setState(() {
      switch (index) {
        case 'Edit Account':
          Navigator.pushNamed(context, AppRouter.editAccount);
          break;
        case 'My Locations':
          Navigator.pushNamed(context, AppRouter.myLocation);
          break;
        case 'My Orders':
          Navigator.pushNamed(context, AppRouter.myOrders);
          break;
        case 'Payment Methods':
          Navigator.pushNamed(context, AppRouter.paymentMethods);
          break;
        case 'My Reviews':
          Navigator.pushNamed(context, AppRouter.myReviews);
          break;
        case 'About Us':
          CustomWidgets.customSnackBar(
              context, AppColor.buttonShadowBlack, 'In Updating...');
          break;
        case 'Data Usage':
          CustomWidgets.customSnackBar(
              context, AppColor.buttonShadowBlack, 'In Updating...');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fullHeight = MediaQuery.of(context).size.height;
    final fullWidth = MediaQuery.of(context).size.width;
    return change
        ? const CustomFallAnimationRive()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SizedBox(
              height: fullHeight,
              width: fullWidth,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: fullHeight * 0.35,
                        color: AppColor.dividerGrey,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 68),
                            child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  sharedPreferences.getString('avatar') != null
                                      ? CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(
                                                color: AppColor.globalPink,
                                              ),
                                          imageUrl: sharedPreferences
                                              .getString('avatar')!,
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              Container(
                                                height: 88,
                                                width: 88,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover)),
                                              ))
                                      : Container(
                                          width: 88,
                                          height: 88,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.camera_alt),
                                              Text('No Image'),
                                            ],
                                          ),
                                        ),
                                  CustomText(
                                      content:
                                          sharedPreferences.getString('name') ??
                                              'No name',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  CustomWidgets.currentAddress(sharedPreferences
                                      .getString('currentAddress')!),
                                  const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 24, top: 40, bottom: 8),
                                            child: CustomText(
                                                content: 'Account Settings',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.globalPink))
                                      ])
                                ])))),
                    Column(
                      children: [
                        SizedBox(
                          height: fullHeight * 0.425,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: kindSetting(
                                    KindSetting.account, RiveUtils.profileIcons)
                                .length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: GestureDetector(
                                      onTap: () {
                                        RiveUtils.changeSMITriggerState(
                                            kindSetting(
                                                    KindSetting.account,
                                                    RiveUtils
                                                        .profileIcons)[index]
                                                .statusTrigger!);
                                        check(kindSetting(KindSetting.account,
                                                RiveUtils.profileIcons)[index]
                                            .label!);
                                      },
                                      child: ListTile(
                                        title: Text(kindSetting(
                                                KindSetting.account,
                                                RiveUtils.profileIcons)[index]
                                            .label!),
                                        leading:
                                            RiveAnimations.profileAnimation(
                                                kindSetting(
                                                    KindSetting.account,
                                                    RiveUtils
                                                        .profileIcons)[index]),
                                        trailing:
                                            const Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                  ),
                                  kindSetting(KindSetting.account,
                                                      RiveUtils.profileIcons)
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
                            color: AppColor.dividerGrey,
                            child: const Padding(
                                padding: EdgeInsets.only(left: 24, bottom: 8),
                                child: CustomText(
                                    content: 'General Settings',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.globalPink))),
                        SizedBox(
                          height: fullHeight * 0.17,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: kindSetting(
                                    KindSetting.general, RiveUtils.profileIcons)
                                .length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    RiveUtils.changeSMITriggerState(kindSetting(
                                            KindSetting.general,
                                            RiveUtils.profileIcons)[index]
                                        .statusTrigger!);
                                    check(kindSetting(KindSetting.general,
                                            RiveUtils.profileIcons)[index]
                                        .label!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: ListTile(
                                      title: Text(kindSetting(
                                              KindSetting.general,
                                              RiveUtils.profileIcons)[index]
                                          .label!),
                                      leading: RiveAnimations.profileAnimation(
                                          kindSetting(KindSetting.general,
                                              RiveUtils.profileIcons)[index]),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.grey.shade300)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    RiveAnimations.lightOrDarkAnimation(context),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 15, top: 15),
                        child: GestureDetector(
                          onTap: () {
                            RiveUtils.changeSMITriggerState(
                                RiveUtils.logOut.statusTrigger!);
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title:
                                    const Text('Are you sure want to logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          change = !change;
                                        });
                                        Navigator.pop(context);
                                        Future.delayed(
                                            const Duration(milliseconds: 2000),
                                            () => supabase.auth.signOut().then(
                                                (value) => Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        AppRouter.loginPage,
                                                        (route) => false)));
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
                          child: Row(
                            children: [
                              RiveAnimations.logOutAnimation(),
                              const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: CustomText(
                                      content: 'Log Out', color: Colors.black))
                            ],
                          ),
                        )),
                    Container(
                      height: fullHeight * 0.1,
                      color: AppColor.dividerGrey,
                    )
                  ],
                ),
              ),
            ));
  }
}
