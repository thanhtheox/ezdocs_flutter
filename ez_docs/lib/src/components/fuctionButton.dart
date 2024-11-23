import 'package:flutter/material.dart';
//import '../assets/constants/color.dart';
import '../assets/constants/responsive.dart';

class FunctionButton extends StatelessWidget {
  final String icon; // Path to the icon image
  final String buttonName;
  final Color backgroundColor;
  final Color text;
  final double iconWidth;
  final double iconHeight;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const FunctionButton({
    super.key,
    required this.icon,
    required this.buttonName,
    required this.backgroundColor,
    required this.text,
    required this.iconWidth,
    required this.iconHeight,
    required this.width,
    required this.height,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
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
        
            Text(
              buttonName,
              style: TextStyle(
                color: text,
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
