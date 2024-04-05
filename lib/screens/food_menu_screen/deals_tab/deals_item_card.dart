import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/food_menu_screen/deals_tab/deals_item_infomation.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DealsItemCard extends StatelessWidget {
  final DealsItemInfomation dealsItemInfomation;
  const DealsItemCard({super.key, required this.dealsItemInfomation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: 328,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(
                      dealsItemInfomation.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 248,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dealsItemInfomation.name,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      dealsItemInfomation.detail,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey1,
                      ),
                    ),
                    Text(
                      dealsItemInfomation.price,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 16,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Divider(
            height: 1,
            color: AppColor.grey6,
          ),
        ),
      ],
    );
  }
}
