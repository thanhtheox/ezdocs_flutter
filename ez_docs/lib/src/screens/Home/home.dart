import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../assets/constants/responsive.dart';
import '../../components/fuctionButton.dart';
import '../../components/header.dart';
import '../../repos/main_links.dart'; // Import CustomAppBar here

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    isLoading = false;
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
                            FunctionButton(
                              icon: 'lib/src/assets/img/IMG_Summarize.png',
                              buttonName: 'Tóm tắt văn bản',
                              text: AppColors.black,
                              backgroundColor: AppColors.orange,
                              iconWidth: 36,
                              iconHeight: 29,
                              width: 300,
                              height: screenWidth *0.08,
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Summarize');
                                }
                            ),
                            SizedBox(width: scale(context, 20)),
                            FunctionButton(
                              icon: 'lib/src/assets/img/IMG_Translate.png',
                              buttonName: 'Dịch thuật',
                              text: AppColors.black,
                              backgroundColor: AppColors.forestGreen,
                              iconWidth: 30,
                              iconHeight: 30,
                              width: 300,
                              height: screenWidth *0.08,
                              onTap: () {
                                Navigator.of(context).pushNamed('/Translation');
                              }
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: scale(context, 50)),
                      FunctionButton(
                        icon: 'lib/src/assets/img/IMG_Chatbot.png',
                        buttonName: 'Chat bot',
                        text: AppColors.black,
                        backgroundColor: AppColors.blue,
                        iconWidth: 36,
                        iconHeight: 36,
                        width: 300,
                        height: 100,
                        onTap: () {
                          Navigator.of(context).pushNamed('/Chatbot');
                        },
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
