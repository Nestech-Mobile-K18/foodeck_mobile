import 'package:template/source/export.dart';

part 'payment_methods_extension.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  final dataCard = supabase.from('card').stream(primaryKey: ['id']);
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.95);
  int currentCard = 0;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                  content: 'Payment Method', fontWeight: FontWeight.bold),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.createCard);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
        ),
        body: StreamBuilder(
            stream: dataCard,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingAnimationRive();
              } else if (snapshot.data!.isEmpty) {
                return SizedBox();
              }
              return SingleChildScrollView(
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (value) {
                      currentCard = value;
                    },
                    scrollBehavior: const ScrollBehavior(),
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: CreditCard(
                                cardName: snapshot.data![index]['card_name'],
                                cardType: snapshot.data![index]['card_type'],
                                cardNumber: snapshot.data![index]
                                    ['card_number']),
                          ),
                          cardInfo(
                              'Card Name', snapshot.data![index]['card_name']),
                          cardInfo('Card Number',
                              snapshot.data![index]['card_number']),
                          cardInfo('Expiry Date',
                              snapshot.data![index]['expiry_date']),
                          cardInfo('CVC/CVV', snapshot.data![index]['cvc']),
                          CustomButton(
                              onPressed: () {},
                              text: const CustomText(
                                  content: 'Remove Card',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              color: AppColor.globalPink)
                        ],
                      );
                    }),
              );
            }),
      ),
    );
  }

  Container cardInfo(String title, String info) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      height: 74,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              content: title,
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400),
          CustomText(content: info)
        ],
      ),
    );
  }
}
