import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/list_credit_card.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/add_credit_card_tab.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  //show dialog when add new card
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Dialog(
          child: AddCreditCardTab(),
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(page: 3)));
            });
          },
        ),
        title: Text(
          "Payment Method",
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColor.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: _showDialog,
            child: Icon(
              Icons.add_outlined,
              size: 24,
              color: AppColor.grey1,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        leadingWidth: 30,
      ),
      body: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: double.infinity,
            ),
            ListCreditCard(),
          ],
        ),
      ),
    );
  }
}
