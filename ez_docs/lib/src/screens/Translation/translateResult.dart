import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../components/header.dart';
import '../../components/fuctionButton.dart';
//import 'package:flutter/src/material/dropdown.dart';
import '../../components/dropdown.dart';

class TranslationResultScreen extends StatefulWidget {
  const TranslationResultScreen({super.key});

  @override
  State<TranslationResultScreen> createState() => _TranslationResultScreenState();
}

class _TranslationResultScreenState extends State<TranslationResultScreen> {
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
    //double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          activeTab: "Tóm tắt",
          onHelpTap: () {
            print("Nút trợ giúp được nhấn");
          },
          onTabSelected: (selectedTab) {
            print("Tab được chọn: $selectedTab");
          },
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tiêu đề
                  const Text(
                    "DỊCH THUẬT",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      // Bên trái: Hai Dropdown
                      Row(
                        children: [
                          Dropdown(
                            items: const ['Anh', 'Pháp', 'Đức'],
                            selectedItem: 'Anh',
                            backgroundColor: AppColors.gray.withOpacity(0.3),
                            textColor: AppColors.black,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_right_alt, color: AppColors.black),
                          const SizedBox(width: 8),
                          const Dropdown(
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
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // Khung Văn bản cần tóm tắt
                      Expanded(
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
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
                                      hintStyle:
                                          TextStyle(color: AppColors.gray),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "$_wordCount/2000",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Khung Văn bản đã tóm tắt
                      Expanded(
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Văn bản đã dịch",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child: Text(
                                //     "$_wordCount/2000", // Hiển thị số từ, thay 0 bằng biến đếm từ nếu có
                                //     style: const TextStyle(color: Colors.grey),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
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
          ),
        ]),
      ),
    );
  }
}
