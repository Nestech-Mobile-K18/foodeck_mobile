import 'package:intl/intl.dart';
import 'package:template/source/export.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({super.key});

  @override
  State<CreateCard> createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();
  @override
  void initState() {
    context.read<CreateCardBloc>().add(CreateCardInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethodsBloc = context.read<PaymentMethodsBloc>();
    final createCardBloc = context.read<CreateCardBloc>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            shape: const UnderlineInputBorder(
                borderSide: BorderSide(width: 8, color: AppColor.dividerGrey)),
            title: const CustomText(
                content: 'Credit Card Info', fontWeight: FontWeight.bold)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
                child: Column(
              children: [
                CustomFormFill(
                    labelText: 'Card Name',
                    textInputType: TextInputType.name,
                    textEditingController: cardNameController,
                    labelColor: AppColor.globalPink,
                    prefixIcons: const Icon(Icons.person_2_outlined),
                    textCapitalization: TextCapitalization.characters,
                    validator: (p0) {
                      if (Validation.cardNameRegex
                          .hasMatch(cardNameController.text)) {
                        return null;
                      } else {
                        return 'Invalid Name';
                      }
                    },
                    onEditingComplete: () =>
                        FocusScope.of(context).nextFocus()),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomFormFill(
                    labelText: 'Card Number',
                    textEditingController: cardNumberController,
                    labelColor: AppColor.globalPink,
                    prefixIcons: const Icon(Icons.credit_card),
                    textInputType: TextInputType.number,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardNumberFormatter(textIndex: 4, replaceText: ' ')
                    ],
                    validator: (p0) {
                      if (cardNumberController.text.length < 19) {
                        return 'Must be 16 digits';
                      } else {
                        return null;
                      }
                    },
                    function: (value) {
                      createCardBloc
                          .add(CreateCardChangeTypeCardEvent(typeCard: value));
                    },
                    icons: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: BlocBuilder<CreateCardBloc, CreateCardState>(
                        builder: (context, state) {
                          switch (state.runtimeType) {
                            case CreateCardChangeTypeCardState:
                              final success =
                                  state as CreateCardChangeTypeCardState;
                              return Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                      image: success.typeCard.isEmpty
                                          ? null
                                          : DecorationImage(
                                              image: AssetImage(success.typeCard
                                                      .startsWith('4')
                                                  ? Assets.visa
                                                  : Assets.master),
                                              fit: BoxFit.cover)));
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ),
                CustomFormFill(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (dateTime != null) {
                      setState(() {
                        expiryDateController.text =
                            DateFormat('MM/yy').format(dateTime);
                      });
                    }
                  },
                  labelText: 'Expiry Date',
                  textEditingController: expiryDateController,
                  labelColor: AppColor.globalPink,
                  readOnly: true,
                  prefixIcons: const Icon(Icons.date_range),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomFormFill(
                    labelText: 'CVC/CVV',
                    validator: (p0) {
                      if (cvcController.text.length < 3) {
                        return 'Must be 3 digits';
                      } else {
                        return null;
                      }
                    },
                    textEditingController: cvcController,
                    labelColor: AppColor.globalPink,
                    prefixIcons: const Icon(Icons.password),
                    textInputType: TextInputType.number,
                    textInputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                  ),
                ),
                CustomButton(
                    onPressed: () {
                      paymentMethodsBloc.add(PaymentMethodsAddCardEvent(
                          context: context,
                          cardName: cardNameController.text,
                          cardNumber: cardNumberController.text,
                          expiryDate: expiryDateController.text,
                          cvc: cvcController.text));
                    },
                    text: const CustomText(
                        content: 'Save',
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                    color: AppColor.globalPink)
              ],
            )),
          ),
        ),
      ),
    );
  }
}
