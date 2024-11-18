import 'package:flutter/material.dart';
import '../assets/constants/color.dart';

class Header extends StatelessWidget {
  final String title;

  const Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Tính toán responsive dựa trên MediaQuery
    double scale(double size) {
      double designWidth = 1920;
      double screenWidth = MediaQuery.of(context).size.width;
      return (size / designWidth) * screenWidth;
    }

    return SafeArea(
      child: Container(
        height: scale(84), // Responsive height
        color: AppColors.mindaro,
        padding: EdgeInsets.all(scale(10)), // Responsive padding
        child: Align(
          alignment: Alignment.centerRight, // Tương tự alignSelf: 'flex-end'
          child: Text(
            title,
            style: TextStyle(
              fontSize: scale(24), // Responsive font size
              color: const Color(0xFF000000), // Màu Black
              // fontWeight: FontWeight.w700, // Uncomment nếu cần
            ),
          ),
        ),
      ),
    );
  }
}
