import 'package:flutter/material.dart';
import 'package:foodeck_app/routes/app_routes.dart';
import 'package:foodeck_app/screens/login_screen/login_screen.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:foodeck_app/utils/app_images.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  final supabase = Supabase.instance.client;
  Future<void> _signOut() async {
    await supabase.auth.signOut(scope: SignOutScope.local);

    if (mounted) {
      setState(() {
        //Notification if success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'You are signed out!',
            style: TextStyle(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColor.primary,
        ));

        //Navigation to LoginScreen
        Navigator.pop(context);
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      });
    } else {
      setState(() {
        //Notification if fail
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Fail to signed out!',
            style: TextStyle(color: AppColor.white),
            textAlign: TextAlign.center,
          ),
          backgroundColor: AppColor.primary,
        ));
      });
    }
  }
  //

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetAnimationDuration: Duration.zero,
        backgroundColor: AppColor.white,
        child: SizedBox(
          height: 120,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do you want to sign out?",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      "No",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _signOut();
                      });
                    },
                    child: Text(
                      "Yes",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey6,
      body: Column(
        children: [
          const SizedBox(
            height: 68,
            width: double.infinity,
          ),
          SizedBox(
            height: 88,
            width: 88,
            child: CircleAvatar(
              backgroundImage: AssetImage(
                AppImage.profile,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            profileInfo.isEmpty ? "" : profileInfo.last.name,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Hồ Chí Minh, Việt Nam",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColor.grey1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 328,
            child: Text(
              "Account Settings",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: AppColor.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Edit Account",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(
                                context, AppRoutes.editProfileScreen);
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "My locations",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(
                                context, AppRoutes.myLocationScreen);
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "My Orders",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.payment_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Payment Methods",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(
                                context, AppRoutes.paymentMethodScreen);
                          });
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_outline,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "My reviews",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 16,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 328,
            child: Text(
              "General Settings",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "About us",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.storage_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Data usage",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 32,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
                SizedBox(
                  width: 328,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            size: 22,
                            color: AppColor.black,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            "Sign out",
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showDialog();
                        },
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 22,
                          color: AppColor.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: 16,
                  child: Divider(
                    height: 1,
                    color: AppColor.grey6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
