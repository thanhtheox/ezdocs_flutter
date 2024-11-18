import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../assets/constants/responsive.dart';
import '../../components/fuctionButton.dart';
import '../../components/header.dart';
//import '../../../src/assets/img/';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Image background
            Positioned.fill(
              child: Image.asset(
                'src/assets/img/IMG_HomeBG.png',
                fit: BoxFit.cover,
              ),
            ),
            // Content on top of the background
            Column(
              children: [
                Header(title: 'Chào mừng bạn đến với EZDocs'), // Header with dynamic title
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Column(
                        children: [
                          Text(
                            'Chào mừng bạn đến với',
                            style: TextStyle(
                              fontSize: scale(context, 56),
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            'EZDocs',
                            style: TextStyle(
                              fontSize: scale(context, 56),
                              fontWeight: FontWeight.w700,
                              color: AppColors.forestGreen,
                            ),
                          ),
                          Text(
                            'Hãy chọn 1 lựa chọn để bắt đầu',
                            style: TextStyle(
                              fontSize: scale(context, 56),
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      // Function buttons
                      Padding(
                        padding: EdgeInsets.only(top: scale(context, 50)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FunctionButton(
                              icon: 'assets/img/IMG_Summarize.png',
                              buttonName: 'Tóm tắt văn bản',
                              backgroundColor: AppColors.orange,
                              iconWidth: 36,
                              iconHeight: 29,
                            ),
                            SizedBox(width: scale(context, 20)),
                            FunctionButton(
                              icon: 'assets/img/IMG_Summarize.png',
                              buttonName: 'Dịch thuật',
                              backgroundColor: AppColors.forestGreen,
                              iconWidth: 30,
                              iconHeight: 30,
                             
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: scale(context, 50)),
                      FunctionButton(
                        icon: 'assets/img/IMG_Summarize.png',
                        buttonName: 'Chat bot',
                        backgroundColor: AppColors.blue,
                        iconWidth: 36,
                        iconHeight: 36,
                      
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
