import 'package:template/pages/export.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({Key? key}) : super(key: key);

  @override
  _PaymentMethodViewState createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  late final List<Payment> _payments;

  final TextEditingController _cardNbrController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  late FocusNode _focusNodeCardNbr;
  late FocusNode _focusNodeCvc;
  late FocusNode _focusNodeName;
  late FocusNode _focusNodeExpiry;

  @override
  void initState() {
    _payments = payments;
    _cardNbrController.setText(_payments[0].cardNbr);
    _nameController.setText(_payments[0].cardName);
    _expiryController.setText(_payments[0].expiryDate);
    _cvcController.setText(_payments[0].cvc);

    _focusNodeCardNbr = FocusNode();
    _focusNodeName = FocusNode();
    _focusNodeCvc = FocusNode();
    _focusNodeExpiry = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _cardNbrController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();

    _focusNodeCardNbr.dispose();
    _focusNodeName.dispose();
    _focusNodeCvc.dispose();
    _focusNodeExpiry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarScreen(
          title: AppStrings.paymentMethod, ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p24, vertical: AppPadding.p12),
        child: Column(
          children: [
            //Payment Method
            SizedBox(
              height: AppSize.s200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _payments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r16),
                      image: DecorationImage(
                        image: AssetImage(_payments[index].image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: AppSize.s328,
                    margin: EdgeInsets.symmetric(horizontal: AppMargin.m4),
                  );
                },
              ),
            ),
            SizedBox(
              height: AppSize.s12,
            ),
// Card Name
            InputText(
              title: AppStrings.name,
              controller: _nameController,
              focusNode: _focusNodeName,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeName);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Card Name is Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.cardNbr,
              controller: _cardNbrController,
              focusNode: _focusNodeCardNbr,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeCardNbr);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Card Number is Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.cardExpDate,
              controller: _expiryController,
              focusNode: _focusNodeExpiry,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeExpiry);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Expiry Date is Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            InputText(
              title: AppStrings.cardCvc,
              controller: _cvcController,
              focusNode: _focusNodeCvc,
              isPass: true,
              onTap: () {
                setState(() {
                  FocusScope.of(context).requestFocus(_focusNodeCvc);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'CVC is Empty';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppSize.s16,
            ),
            //   Button(
            //     label: AppStrings.save,
            //     width: double.infinity,
            //     height: AppSize.s62,
            //     colorBackgroud: ColorsGlobal.globalPink,
            //     colorLabel: ColorsGlobal.white,
            //     onPressed: () => _handleEditAccount(),
            //   )
          ],
        ),
      ),
    );
  }
}
