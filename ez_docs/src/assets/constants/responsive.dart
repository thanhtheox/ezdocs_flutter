import 'package:flutter/material.dart';

/// Hàm `scale` tính toán kích thước responsive.
/// [size]: Kích thước gốc dựa trên thiết kế.
/// [designWidth]: Chiều rộng thiết kế (mặc định 1920).
double scale(BuildContext context, double size, {double designWidth = 1920}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (size / designWidth) * screenWidth;
}
