import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container xám nhạt để tạo overlay
        Container(
          color: Colors.black.withOpacity(0.5), // Màu xám nhạt với độ mờ là 50%
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        // Loading indicator ở giữa màn hình
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
