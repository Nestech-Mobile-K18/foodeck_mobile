import 'package:flutter/material.dart';

import 'package:template/pages/profile/vm/profile_view_model.dart';
import 'package:template/pages/profile/widgets/avatar_and_name.dart';
import 'package:template/pages/profile/widgets/account_settings.dart';
import 'package:template/pages/profile/widgets/general_settings.dart';
import 'package:template/resources/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _viewModel = ProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsGlobal.dividerGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<Map<String, dynamic>?>(
                stream: _viewModel.getUserDataByIdStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    var userData = snapshot.data!;
                    String? avatarPath =
                        userData['avatar']; // Get avatar path from userData

                    return AvatarAndName(
                      imgUrl: avatarPath,
                      name: userData['name'] ?? 'N/A',
                      address: userData['address'] ?? 'N/A',
                    );
                  }
                },
              ),
              const AccountSettings(),
               const GeneralSettings(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
