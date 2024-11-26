import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../components/dropdown.dart';
import '../../components/header.dart';
import '../../components/fuctionButton.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _textController = TextEditingController();
  int _wordCount = 0;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
  }

  @override
  void dispose() {
    _textController.removeListener(_updateWordCount);
    _textController.dispose();
    super.dispose();
  }

  void _updateWordCount() {
    setState(() {
      _wordCount = _textController.text.trim().isEmpty
          ? 0
          : _textController.text.trim().split(RegExp(r'\s+')).length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          activeTab: "Dịch thuật",
          onHelpTap: () {
            print("Help button pressed");
          },
          onTabSelected: (selectedTab) {
            print("Selected Tab: $selectedTab");
          },
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "DỊCH THUẬT",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      // Bên trái: Hai Dropdown
                      Row(
                        children: [
                          Dropdown(
                            items: ['Anh', 'Pháp', 'Đức'],
                            selectedItem: 'Anh',
                            backgroundColor: AppColors.gray.withOpacity(0.3),
                            textColor: AppColors.black,
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_right_alt, color: AppColors.black),
                          SizedBox(width: 8),
                          Dropdown(
                            items: ['Việt', 'Hoa', 'Nhật'],
                            selectedItem: 'Việt',
                            backgroundColor: AppColors.mindaro,
                            textColor: AppColors.black,
                          ),
                        ],
                      ),
                
                      ElevatedButton(
                        onPressed: () {
                          print("Nút Dịch được nhấn");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          
                          ),
                        ),
                        child: const Text(
                          "Dịch",
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: "Dán văn bản cần dịch...",
                                hintStyle: TextStyle(color: AppColors.gray),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "$_wordCount/2000",
                              style: const TextStyle(color: AppColors.gray),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "- hoặc -",
                      style: TextStyle(color: AppColors.gray),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const FunctionButton(
                    icon: 'lib/src/assets/img/IMG_Upload.png',
                    buttonName: 'Upload tài liệu',
                    text: AppColors.white,
                    backgroundColor: AppColors.forestGreen,
                    iconWidth: 36,
                    iconHeight: 29,
                    width: 300,
                    height: 70,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
