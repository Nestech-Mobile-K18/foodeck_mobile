import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:template/pages/export.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<void> logout() async {
    // print('logout gmail gg');

    // var isSignedIn = await GoogleSignIn().isSignedIn();
    // if (isSignedIn) await GoogleSignIn().signOut();
  }

  Future<void> handleEditAccount() async {
    Navigator.of(context).pushNamed(RouteName.editAccount);
  }

  Future<void> handleMyLocation() async {
    Navigator.of(context).pushNamed(RouteName.myLocation);
  }

  Future<void> handleMyOrder() async {
    Navigator.of(context).pushNamed(RouteName.history);
  }

  Future<void> handlePaymentMethod() async {
    Navigator.of(context).pushNamed(RouteName.paymentMethod);
  }

  Future<void> handleMyReview() async {
    Navigator.of(context).pushNamed(RouteName.review);
  }

  Future<void> handleAboutUs() async {
    Navigator.of(context).pushNamed(RouteName.aboutUs);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: AppPadding.p24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppSize.s88,
                height: AppSize.s88,
                // aspectRatio: 1,
                child: const CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/id/64/4326/2884'),
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Text('John Doe', style: AppTextStyle.title),
              SizedBox(
                height: AppSize.s5,
              ),
              Text('Lahore, Pakistan', style: AppTextStyle.decription),
              SizedBox(
                height: AppSize.s40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: AppPadding.p12),
                  child: Text(AppStrings.accountSettings,
                      style: AppTextStyle.textPinkBold),
                ),
              ),
              ListView(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                children: [
                  ListTile(
                      leading: const Icon(Icons.account_circle_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handleEditAccount(),
                      ),
                      title: Text(AppStrings.editAccount,
                          style: AppTextStyle.label)),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handleMyLocation(),
                      ),
                      title: Text(AppStrings.myLocations,
                          style: AppTextStyle.label)),
                  const Divider(),
                  ListTile(
                      leading: const Icon(
                        CupertinoIcons.cube_box,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handleMyOrder(),
                      ),
                      title:
                          Text(AppStrings.myOrders, style: AppTextStyle.label)),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.payment),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handlePaymentMethod(),
                      ),
                      title: Text(AppStrings.paymentMethod,
                          style: AppTextStyle.label)),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.star_outline_outlined),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handleMyReview(),
                      ),
                      title: Text(AppStrings.myReviews,
                          style: AppTextStyle.label)),
                  const Divider(),
                ],
              ),
              SizedBox(
                height: AppSize.s40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: AppPadding.p12),
                  child: Text(AppStrings.generalSettings,
                      style: TextStyle(
                          fontSize: AppSize.s15,
                          fontWeight: FontWeight.bold,
                          color: ColorsGlobal.globalPink)),
                ),
              ),
              ListView(
                // scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // fix cannot scroll in listview mobile
                children: [
                  ListTile(
                      leading:
                          const Icon(CupertinoIcons.exclamationmark_circle),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => handleAboutUs(),
                      ),
                      title:
                          Text(AppStrings.aboutUs, style: AppTextStyle.label)),
                  const Divider(),
                  ListTile(
                      leading: const Icon(Icons.logout),
                      trailing: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        onPressed: () => logout(),
                      ),
                      title:
                          Text(AppStrings.logOut, style: AppTextStyle.label)),
                  const Divider(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
