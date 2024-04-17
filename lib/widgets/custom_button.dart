import 'package:flutter/material.dart';
import 'package:template/resources/colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final double? border;
  final String title;
  final double? titleSize;
  final Color? colorTitle;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.color,
    this.border,
    required this.colorTitle,
    this.titleSize,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy chiều cao màn hình
    double screenHeight = MediaQuery.of(context).size.height;

    // Tính toán padding dựa trên tỉ lệ phần trăm của chiều cao màn hình, ví dụ ở đây là 5%
    double verticalPadding = screenHeight * 0.02;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // Áp dụng padding dọc theo tỉ lệ chiều cao màn hình
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          border:
              Border.all(width: border ?? 0, color: ColorsGlobal.globalGrey),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: titleSize ?? 17,
            fontWeight: FontWeight.w700,
            color: colorTitle ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
