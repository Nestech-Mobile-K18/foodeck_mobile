import 'package:flutter/material.dart';
import 'package:template/pages/cart/vm/cart_view_model.dart';
import 'package:template/resources/colors.dart';
import 'package:template/widgets/method_button.dart';

class CouponBottomSheet extends StatefulWidget {
  final CartViewModel cartViewModel;

  const CouponBottomSheet({super.key, required this.cartViewModel});

  @override
  State<CouponBottomSheet> createState() => _CouponBottomSheetState();
}

class _CouponBottomSheetState extends State<CouponBottomSheet> {
  late String? _selectedCouponCode;

  @override
  void initState() {
    super.initState();
    _selectedCouponCode = widget.cartViewModel.selectedCouponCode;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Select discount code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.cartViewModel.coupons.length,
            itemBuilder: (context, index) {
              final coupon = widget.cartViewModel.coupons[index];
              return ListTile(
                title: Text(coupon.code ?? ''),
                subtitle: Text('Discount: \$${coupon.value.toString()}'),
                trailing: Radio<String>(
                  value: coupon.code ?? '',
                  groupValue: _selectedCouponCode,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCouponCode = value;
                    });
                    widget.cartViewModel.selectCoupon(value ?? '', coupon
                        .value??0);
                  },
                ),
                onTap: () {
                  setState(() {
                    _selectedCouponCode = coupon.code;
                  });
                  widget.cartViewModel.selectCoupon(coupon.code ?? '', coupon
                      .value??0);
                },
              );
            },
          ),
        ),
        MethodButton(
          color: ColorsGlobal.globalPink,
          title: 'Select',
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
