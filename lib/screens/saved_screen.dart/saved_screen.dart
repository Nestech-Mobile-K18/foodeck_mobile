import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_card.dart';
import 'package:foodeck_app/screens/saved_screen.dart/saved_item_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 68,
              width: double.infinity,
            ),
            Container(
              width: 328,
              alignment: Alignment.centerLeft,
              child: Text(
                "Save (${savedItems.length})",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            savedItems.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    height: MediaQuery.sizeOf(context).height * 0.85,
                    child: Text(
                      "You have no favorites yet!",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColor.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(0),
                    height: 240 * savedItems.length.toDouble(),
                    width: 348,
                    child: ListView.builder(
                      itemCount: savedItems.length,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => SavedItemCard(
                        savedItems: savedItems[index],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
