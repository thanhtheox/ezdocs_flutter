import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../assets/constants/responsive.dart';
import '../../components/fuctionButton.dart';
import '../../components/header.dart'; // Import CustomAppBar here

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          activeTab: "Trợ giúp", // Set the active tab
          onHelpTap: () {
            // Handle help button action
            print("Help button pressed");
          },
          onTabSelected: (selectedTab) {
            // Handle tab navigation
            print("Selected Tab: $selectedTab");
          },
        ),
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'lib/src/assets/img/IMG_HomeBG.png',
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Column(
              children: [
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
                            const FunctionButton(
                              icon: 'lib/src/assets/img/IMG_Summarize.png',
                              buttonName: 'Tóm tắt văn bản',
                              text: AppColors.black,
                              backgroundColor: AppColors.orange,
                              iconWidth: 36,
                              iconHeight: 29,
                              width: 200,
                              height: 500,
                            ),
                            SizedBox(width: scale(context, 20)),
                            const FunctionButton(
                              icon: 'lib/src/assets/img/IMG_Translate.png',
                              buttonName: 'Dịch thuật',
                              text: AppColors.black,
                              backgroundColor: AppColors.forestGreen,
                              iconWidth: 30,
                              iconHeight: 30,
                              width: 200,
                              height: 500,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: scale(context, 50)),
                      const FunctionButton(
                        icon: 'lib/src/assets/img/IMG_Chatbot.png',
                        buttonName: 'Chat bot',
                        text: AppColors.black,
                        backgroundColor: AppColors.blue,
                        iconWidth: 36,
                        iconHeight: 36,
                        width: 200,
                        height: 500,
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
