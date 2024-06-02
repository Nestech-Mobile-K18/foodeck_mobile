part of 'payment_methods.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  CardType type = CardType.master;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();
  bool select = false;
  bool choice = false;

  addCardToSupaBase() async {
    try {
      await supabase.from('card').insert({
        'card_name': cardNameController.text,
        'card_number': cardNumberController.text,
        'expiry_date': expiryDateController.text,
        'cvc': cvcController.text,
        'card_type': type
      });
    } catch (e) {
      print(e);
      if (mounted) {
        CustomWidgets.customSnackBar(
            context, AppColor.buttonShadowBlack, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Payment Method', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormFill(
                        labelText: 'Card Name',
                        textEditingController: cardNameController,
                        labelColor: AppColor.globalPink,
                        prefixIcons: Icon(Icons.person_2_outlined),
                      ),
                      CustomFormFill(
                        labelText: 'Card Number',
                        textEditingController: cardNumberController,
                        labelColor: AppColor.globalPink,
                        prefixIcons: Icon(Icons.credit_card),
                        icons: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Assets.visa),
                                    fit: BoxFit.cover))),
                      ),
                      CustomFormFill(
                        labelText: 'Expiry Date',
                        textEditingController: expiryDateController,
                        labelColor: AppColor.globalPink,
                        prefixIcons: Icon(Icons.date_range),
                      ),
                      CustomFormFill(
                        labelText: 'CVC/CVV',
                        textEditingController: cvcController,
                        labelColor: AppColor.globalPink,
                        prefixIcons: Icon(Icons.password),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, bottom: 24),
                        child: Row(
                          children: [
                            Flexible(
                              child: RadioListTile.adaptive(
                                activeColor: AppColor.globalPink,
                                contentPadding: EdgeInsets.zero,
                                title: Row(
                                  children: [
                                    Container(
                                        height: 56,
                                        width: 56,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    AssetImage(Assets.master),
                                                fit: BoxFit.cover)))
                                  ],
                                ),
                                value: CardType.master,
                                groupValue: type,
                                onChanged: (value) {
                                  setState(() {
                                    type = value!;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile.adaptive(
                                activeColor: AppColor.globalPink,
                                title: Row(
                                  children: [
                                    Container(
                                        height: 56,
                                        width: 56,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(Assets.visa),
                                                fit: BoxFit.cover)))
                                  ],
                                ),
                                contentPadding: EdgeInsets.zero,
                                value: CardType.visa,
                                groupValue: type,
                                onChanged: (value) {
                                  setState(() {
                                    type = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              CustomButton(
                  onPressed: () {
                    addCardToSupaBase();
                  },
                  text: const CustomText(
                      content: 'Add Card',
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                  color: AppColor.globalPink)
            ],
          ),
        ),
      ),
    );
  }
}
