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
              FutureBuilder<List<dynamic>?>(
                future: _viewModel.getUserDataById(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display loader while loading
                  } else if (snapshot.hasError) {
                    return Text(
                        "Error: ${snapshot.error}"); // Display errors if any
                  } else if (snapshot.hasData) {
                    // Assuming the returned data is not empty and has at least one record
                    var userData = snapshot.data?.first; // Get the first record
                    return AvatarAndName(
                      name: userData?['name'] ?? 'N/A',
                      address: userData?['address'] ?? 'N/A',
                    );
                  } else {
                    return Text("No data"); // Displayed when there is no data
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
