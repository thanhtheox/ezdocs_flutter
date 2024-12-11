import 'dart:io';
import 'package:flutter/material.dart';
import '../../assets/constants/color.dart';
import '../../components/header.dart';
import '../../components/fuctionButton.dart';
//import 'package:flutter/src/material/dropdown.dart';
import '../../components/dropdown.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../repos/main_links.dart';
import '../../repos/rewrite.dart';
import './sum.dart';

class SummaryResultScreen extends StatefulWidget {
  const SummaryResultScreen({super.key});

  @override
  State<SummaryResultScreen> createState() => _SummaryResultScreenState();
}

class _SummaryResultScreenState extends State<SummaryResultScreen> {
  final TextEditingController _textController = TextEditingController();
  int _wordCount = 0;
  final TextEditingController _textEditingController = TextEditingController();

  Future<void> _generatePDF(String geminiOutput) async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    document.pages.add().graphics.drawString(
        geminiOutput, PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 150, 20));
    final List<int> bytes = await document.save();

    //Launch file.
    await saveAndLaunchFile(bytes, 'Invoice.pdf');
    document.dispose();
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    try {
      final directory = await FilePicker.platform.getDirectoryPath(); // Or getTemporaryDirectory()
      final file = File('$directory/$fileName');
      await file.writeAsBytes(bytes);

      print('File saved at: ${file.path}');

      // Optional: Open the saved file using the open_file package
      // await OpenFile.open(file.path);

    } catch (e) {
      print('Error saving file: $e');
      // Handle error (e.g., show a dialog)
    }
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(_updateWordCount);
    _loadData();
  }

  @override
  void dispose() {
    _textController.removeListener(_updateWordCount);
    _textController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final data = await callGeminiAPI(text);
      setState(() {
        _textEditingController.text = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        _textEditingController.text = 'Error loading data';
        isLoading = false;
      });
    }
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
                    "TÓM TẮT VĂN BẢN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Dropdown(
                            items: const [
                              'Tóm tắt dạng liệt kê',
                              'Tóm tắt dạng văn bản'
                            ],
                            selectedItem: 'Tóm tắt dạng văn bản',
                            backgroundColor: AppColors.mindaro,
                            textColor: AppColors.black,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("Nút tóm tắt được nhấn");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Tóm tắt",
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          await _generatePDF(geminiOutput);

                        },
                        child: const Text('Download PDF'),
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
                                      hintText: "Dán văn bản cần tóm tắt...",
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
                                isLoading ? const CircularProgressIndicator() :
                                TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: _textEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "VB...",
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
