import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/my_locations_info.dart';
import 'package:foodeck_app/screens/profile_screen/your_locations/my_locations_screen.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyLocationsCard extends StatefulWidget {
  final MyLocationsInfo myLocationInfo;
  const MyLocationsCard({super.key, required this.myLocationInfo});

  @override
  State<MyLocationsCard> createState() => _MyLocationsCardState();
}

class _MyLocationsCardState extends State<MyLocationsCard> {
  //
  late TextEditingController kindLocationController =
      TextEditingController(text: widget.myLocationInfo.kind.toString());
  @override
  void initState() {
    super.initState();
    kindLocationController;
  }

  @override
  void dispose() {
    kindLocationController.dispose();
    super.dispose();
  }

//
  void _updateDetailLocation() {
    setState(() {
      myLocations[myLocations.indexWhere((myLocation) =>
              myLocation.location == widget.myLocationInfo.location)]
          .kind = kindLocationController.text;
    });
  }

  //
  void _deleteLocation() {
    setState(() {
      myLocations.removeWhere((myLocation) =>
          myLocation.location == widget.myLocationInfo.location);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyLocationsScreen()));
    });
  }

//update data on supabase
  final supabase = Supabase.instance.client;
  Future<void> _updateDataSupabase() async {
    final userInfo = await supabase
        .from("user_account")
        .select("id")
        .filter(
          "email",
          "eq",
          profileInfo[0].email.toString(),
        )
        .single();
    final userID = userInfo.entries.single.value;

    //
    await supabase.from("locations").delete().match({
      "user_id": userID,
      "location": widget.myLocationInfo.location.toString(),
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 140,
      width: 328,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.grey6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 24,
            color: AppColor.grey1,
          ),
          const SizedBox(
            width: 10,
            height: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                height: 25,
                width: 270,
                controller: kindLocationController,
                onFieldSubmitted: (value) {
                  setState(() {
                    _updateDetailLocation();
                  });
                },
                obscureText: false,
                errorText: "",
                hintText: "Detail your kind of location",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
              ),
              SizedBox(
                width: 270,
                child: Text(
                  widget.myLocationInfo.location,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _deleteLocation();

                    _updateDataSupabase();
                  });
                },
                child: Container(
                  width: 270,
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete,
                    size: 24,
                    color: AppColor.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
