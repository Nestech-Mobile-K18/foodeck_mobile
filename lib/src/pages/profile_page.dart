import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:template/src/features/auth/bloc/authentication_bloc.dart';
import 'package:template/src/pages/error_page.dart';
import 'package:template/src/pages/export.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> logout() async {
    context.read<AuthenticationBloc>().add(AuthLogOutStarted());
    GoRouter.of(context).push(RouteName.login);
  }

  Future<void> handleEditAccount() async {
     GoRouter.of(context).push(RouteName.editAccount);
  }

  Future<void> handleMyLocation() async {
     GoRouter.of(context).push(RouteName.myLocation);

  }

  Future<void> handleMyOrder() async {
     GoRouter.of(context).push(RouteName.history);

  }

  Future<void> handlePaymentMethod() async {
     GoRouter.of(context).push(RouteName.paymentMethod);

  }

  Future<void> handleMyReview() async {
     GoRouter.of(context).push(RouteName.review);

  }

  Future<void> handleAboutUs() async {
     GoRouter.of(context).push(RouteName.aboutUs);

  }

Widget profile(AccountInfo user){
  return SingleChildScrollView(
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
                child:  CircleAvatar(
                  backgroundImage:
                      NetworkImage(user.avatar!),
                ),
              ),
              SizedBox(
                height: AppSize.s5,
              ),
              Text(user.name, style: AppTextStyle.title),
              SizedBox(
                height: AppSize.s5,
              ),
              Text(user.phone!, style: AppTextStyle.decription),
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
      );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) {
              final AccountInfo user = state.userInfor!;
              return profile(user);
            }
            return ErrorPage(onTryAgainPressed: () {
              context.read<AuthenticationBloc>().add(AppStarted());
            });
          },
        )
    );
  }
}
