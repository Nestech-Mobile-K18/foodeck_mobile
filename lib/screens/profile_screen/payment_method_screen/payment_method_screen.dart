import 'package:flutter/material.dart';
import 'package:foodeck_app/screens/home_screen/home_screen.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/credit_card_components/credit_card_info.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/list_credit_card.dart';
import 'package:foodeck_app/screens/profile_screen/payment_method_screen/add_credit_card_tab.dart';
import 'package:foodeck_app/screens/profile_screen/profile_info.dart';
import 'package:foodeck_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  //
  //
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  @override
  void initState() {
    super.initState();
    cardNameController;
    cardNumberController;
    expiryDateController;
    cvcController;
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

//show dialog when add new card
  void _showDialog() {
    creditCardInfo.length > 5
        ? showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                height: 150,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColor.grey1.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: double.infinity,
                    ),
                    Icon(
                      Icons.notifications,
                      size: 24,
                      color: AppColor.red,
                    ),
                    Text(
                      "Your cards is overlimit.Please delete one of them for continuing add new card!",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        : showDialog(
            useSafeArea: true,
            context: context,
            builder: (context) => Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Dialog(
                  alignment: Alignment.center,
                  child: AddCreditCardTab(
                    cardNameController: cardNameController,
                    cardNumberController: cardNumberController,
                    expiryDateController: expiryDateController,
                    cvcController: cvcController,
                    addCard: () {
                      setState(() {
                        _addCreditCard();
                        _insertDataSupabase();
                      });
                    },
                  ),
                ),
              ),
            ),
          );
  }

  //
  void _addCreditCard() {
    final newCreditCard = CreditCardInfo(
      id: DateTime.now().toString(),
      cardNumber: cardNumberController.text,
      cardName: cardNameController.text,
      cardExpiryDate: expiryDateController.text,
      cardCVC: cvcController.text,
      isSelected: false,
    );
    setState(() {
      creditCardInfo.add(newCreditCard);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PaymentMethodScreen()));
    });
  }

  //
  //update data on supabase
  final supabase = Supabase.instance.client;
  Future<void> _insertDataSupabase() async {
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
    await supabase.from("credit_card").insert({
      "card_name": cardNameController.text,
      "card_number": cardNumberController.text,
      "card_expiry_date": expiryDateController.text,
      "card_cvc": cvcController.text,
      "user_id": userID,
    });
  }
  //

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
