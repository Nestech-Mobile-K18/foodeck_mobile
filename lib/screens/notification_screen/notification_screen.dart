import 'package:flutter/material.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 68,
            width: double.infinity,
          ),
          SizedBox(
            width: 328,
            child: Text(
              "Notifications",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 328,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: AppColor.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Your order has arrived",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  "2m",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Text(
                  "Your order is on its way",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "50m",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Text(
                  "Your order has been placed",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "1h",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Text(
                  "Confirm your phone number",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "5d",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We have updated our Privacy Policy",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "View Privacy Policy",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grey1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  "6d",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Text(
                  "Your order has been placed",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "1w",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Foodeck",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "Watch our video",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppColor.grey1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  "1w",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey1,
                  ),
                  textAlign: TextAlign.right,
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
        ],
      ),
    );
  }
}
