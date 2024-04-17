import 'package:flutter/material.dart';
import 'package:template/pages/profile/vm/profile_view_model.dart';
import 'package:template/pages/profile/widgets/avatar_and_name.dart';
import 'package:template/pages/profile/widgets/account_settings.dart';
import 'package:template/pages/profile/widgets/general_settings.dart';
import 'package:template/resources/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

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
              FutureBuilder<Map<String, dynamic>?>(
                future: _viewModel.getUserDataById(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var userData = snapshot.data!;
                    return AvatarAndName(
                      name: userData['name'] ?? 'N/A',
                      address: userData['address'] ??
                          'N/A', // Thay đổi 'address' thành 'address_1'
                    );
                  } else {
                    return Text("No data");
                  }
                },
              ),
              AccountSettings(),
              GeneralSettings(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
