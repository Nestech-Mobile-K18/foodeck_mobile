import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/your_locations_card.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/your_locations_info.dart';

import 'package:foodeck_app/widgets/header.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class YourLocationsScreen extends StatefulWidget {
  final YourLocationsInfo? myLocationInfo;
  const YourLocationsScreen({super.key, this.myLocationInfo});

  @override
  State<YourLocationsScreen> createState() => _YourLocationsScreenState();
}

class _YourLocationsScreenState extends State<YourLocationsScreen> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: Header(
          headerTitle: "Your locations",
          onBack: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            page: 3,
                          )));
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            yourLocations.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    height: MediaQuery.sizeOf(context).height * 0.85,
                    child: Text(
                      "You have no Location yet!",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SizedBox(
                    height: 160 * yourLocations.length.toDouble(),
                    width: 328,
                    child: ListView.builder(
                      itemCount: yourLocations.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => YourLocationsCard(
                        myLocationInfo: yourLocations[index],
                      ),
                    ),
                  ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
