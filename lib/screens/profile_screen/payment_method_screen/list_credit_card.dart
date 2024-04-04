import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/tab_credit_card.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ListCreditCard extends StatefulWidget {
  const ListCreditCard({super.key});

  @override
  State<ListCreditCard> createState() => _ListCreditCardState();
}

class _ListCreditCardState extends State<ListCreditCard> {
  @override
  Widget build(BuildContext context) {
    return creditCardInfo.isNotEmpty
        ? Container(
            alignment: Alignment.centerLeft,
            width: creditCardInfo.length * 328 + 30,
            height: 660,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView.builder(
                itemCount: creditCardInfo.length,
                scrollDirection: Axis.horizontal,
                reverse: true,
                dragStartBehavior: DragStartBehavior.start,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => TabCreditCard(
                  creditCardInfo: creditCardInfo[index],
                ),
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: Center(
              child: Text(
                "You have no credit card for payment!",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary,
                ),
              ),
            ),
          );
  }
}
