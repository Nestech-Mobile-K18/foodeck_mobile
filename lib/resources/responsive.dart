import 'package:flutter/material.dart';

class Responsive {
  // Trả về chiều rộng của màn hình
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Trả về chiều cao của màn hình
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Trả về kích thước của một khối theo chiều rộng
  static double blockSizeWidth(BuildContext context, {double dividedBy = 1}) {
    return screenWidth(context) / dividedBy;
  }

  // Trả về kích thước của một khối theo chiều cao
  static double blockSizeHeight(BuildContext context, {double dividedBy = 1}) {
    return screenHeight(context) / dividedBy;
  }

  // Trả về tỷ lệ của cỡ chữ so với cỡ chữ mặc định của thiết bị
  static double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  // Kiểm tra xem thiết bị có ở chế độ dọc không
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  // Kiểm tra xem thiết bị có ở chế độ ngang không
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
