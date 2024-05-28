import 'package:flutter/material.dart';
import 'package:template/widgets/custom_textfield.dart';
import '../../../resources/const.dart';
import '../../../widgets/custom_text.dart';
import '../vm/payment_view_model.dart';
import 'payment_input_view.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  final PaymentViewModel _viewModel = PaymentViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          title: StringExtensions.paymentMethod,
          color: ColorsGlobal.globalBlack,
          size: 17,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PaymentInputView(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _viewModel.getPaymentMethods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    title: "You haven't added any payment method yet.",
                    size: 18,
                    color: ColorsGlobal.globalBlack,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PaymentInputView(),
                        ),
                      );
                    },
                    child: const CustomText(
                      title: "Add new payment method",
                      size: 15,
                      color: ColorsGlobal.globalBlue,
                    ),
                  )
                ],
              ),
            );
          } else {
            final paymentMethods = snapshot.data!;
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Stack(
                      children: [
                        Image.asset(MediaRes.creditCard, fit: BoxFit.cover),
                        Positioned(
                          top: 50,
                          right: 35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                title: '.... ' +
                                    method['card_number'].substring(15),
                                color: ColorsGlobal.globalWhite,
                                size: 25,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                              method['payment_method'] == 'Visa'
                                  ? Image.asset(
                                MediaRes.visaCard,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              )
                                  : Image.asset(
                                MediaRes.masterCard,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 170,
                          left: 25,
                          child: CustomText(
                            title: method['card_name'],
                            color: ColorsGlobal.globalWhite,
                            size: 25,
                          ),
                        ),
                        Positioned(
                          bottom: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                title: 'Card Name',
                                controller: TextEditingController(
                                    text: method['card_name']),
                                readOnly: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                title: 'Card Number',
                                controller: TextEditingController(
                                    text: method['card_number']),
                                readOnly: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                title: 'Expiry Date',
                                controller: TextEditingController(
                                    text: method['expiry_date']),
                                readOnly: true,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                title: 'CVC',
                                controller: TextEditingController(
                                    text: method['cvc']),
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
