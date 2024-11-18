import 'package:flutter/material.dart';
import '../assets/constants/color.dart';
import '../assets/constants/responsive.dart';

class FunctionButton extends StatelessWidget {
  final String icon; // Path to the icon image
  final String buttonName;
  final Color backgroundColor;
  final double iconWidth;
  final double iconHeight;

  const FunctionButton({
    Key? key,
    required this.icon,
    required this.buttonName,
    required this.backgroundColor,
    required this.iconWidth,
    required this.iconHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        // Add onTap functionality if needed
      },
      child: Container(
        height: scale(context, 200),
        width: scale(context, 400),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(scale(context, 15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Container
            Padding(
              padding: EdgeInsets.only(right: scale(context, 20)),
              child: Image.asset(
                icon,
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            // Button Text
            Text(
              buttonName,
              style: TextStyle(
                color: AppColors.black,
                fontSize: scale(context, 32),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
