import 'package:flutter/cupertino.dart';
import 'package:template/source/export.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfilePageBloc>().add(ProfilePageInitialEvent(
        image: sharedPreferences.getString('avatar')!,
        name: sharedPreferences.getString('name')!,
        address: sharedPreferences.getString('currentAddress')!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profilePageBloc = context.read<ProfilePageBloc>();
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listenWhen: (previous, current) => current is ProfilePageActionState,
      buildWhen: (previous, current) => current is! ProfilePageActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProfilePageLoadedState:
            final success = state as ProfilePageLoadedState;
            return success.load
                ? const CustomFallAnimationRive()
                : Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: SizedBox(
                        height: 1100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                  color: AppColor.dividerGrey,
                                  padding: const EdgeInsets.only(top: 68),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              success.image != null
                                                  ? CachedNetworkImage(
                                                      placeholder: (context,
                                                              url) =>
                                                          const CircularProgressIndicator(
                                                            color: AppColor
                                                                .globalPink,
                                                          ),
                                                      imageUrl: success.image!,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                            height: 88,
                                                            width: 88,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ))
                                                  : Container(
                                                      width: 88,
                                                      height: 88,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.grey),
                                                      child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              Icons.camera_alt),
                                                          Text('No Image'),
                                                        ],
                                                      ),
                                                    ),
                                              CustomText(
                                                  content:
                                                      success.name ?? 'No name',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              CustomWidgets.currentAddress(
                                                  success.address!),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 40, left: 24),
                                          child: CustomText(
                                              content: 'Account Settings',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor.globalPink),
                                        )
                                      ])),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 350,
                                      child:
                                          buildListView(KindSetting.account)),
                                  Container(
                                      height: 70,
                                      alignment: Alignment.bottomLeft,
                                      color: AppColor.dividerGrey,
                                      padding: const EdgeInsets.only(left: 24),
                                      child: const CustomText(
                                          content: 'General Settings',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.globalPink)),
                                  SizedBox(
                                      height: 130,
                                      child:
                                          buildListView(KindSetting.general)),
                                  Divider(color: Colors.grey.shade300),
                                  RiveAnimations.lightOrDarkAnimation(context),
                                  Divider(color: Colors.grey.shade300),
                                  GestureDetector(
                                    onTap: () {
                                      RiveUtils.changeSMITriggerState(
                                          RiveUtils.logOut.statusTrigger!);
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: const Text(
                                              'Are you sure want to logout?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  profilePageBloc.add(
                                                      ProfilePageLogOutEvent());
                                                },
                                                child: const CustomText(
                                                    content: 'Yes',
                                                    color: Colors.red)),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const CustomText(
                                                    content: 'No',
                                                    color: Colors.blue))
                                          ],
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      child: Row(
                                        children: [
                                          RiveAnimations.logOutAnimation(),
                                          const Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: CustomText(
                                                  content: 'Log Out',
                                                  color: Colors.black))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
        }
        return const SizedBox();
      },
    );
  }

  ListView buildListView(KindSetting type) {
    final profilePageBloc = context.read<ProfilePageBloc>();
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          RestaurantData.kindSetting(type, RiveUtils.profileIcons).length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          profilePageBloc.add(ProfilePageNavigateEvent(
              gate: RestaurantData.kindSetting(
                      type, RiveUtils.profileIcons)[index]
                  .label!,
              context: context,
              index: index,
              type: type));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ListTile(
            title: Text(
                RestaurantData.kindSetting(type, RiveUtils.profileIcons)[index]
                    .label!),
            leading: RiveAnimations.profileAnimation(RestaurantData.kindSetting(
                type, RiveUtils.profileIcons)[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return Divider(color: Colors.grey.shade300);
      },
    );
  }
}
