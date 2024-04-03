import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodeck_app/screens/explore_screen/banner/banner_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BannerItemCard extends StatefulWidget {
  final BannerItemInfo bannerItemInfo;
  const BannerItemCard({super.key, required this.bannerItemInfo});

  @override
  State<BannerItemCard> createState() => _BannerItemCardState();
}

class _BannerItemCardState extends State<BannerItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(
            widget.bannerItemInfo.image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 200,
            child: Text(
              widget.bannerItemInfo.title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 200,
            child: Text(
              widget.bannerItemInfo.discription,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColor.grey1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: 200,
            child: Text(
              widget.bannerItemInfo.subtext,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColor.grey1,
              ),
            ),
          ),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.bannerItemInfo.price,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
