import 'dart:io';
import 'dart:typed_data';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:ez_docs/src/repos/rewrite.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import file_picker
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../components/header.dart';
import '../../components/fuctionButton.dart';
import '../../assets/constants/color.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final TextEditingController _textController = TextEditingController();
  int _wordCount = 0;
  late PlatformFile selectedFile; // Add state for the selected file
  late Uint8List fileBytes; // Store file bytes

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

  void _pickFile() {
    FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'], ).then((result) {  // Correct usage
      if (result != null) {
        print("Noice");
        String? ext = result.files.single.extension;
        File file = File(result.files.single.path!);
        late String text;
        if(ext == 'pdf') {
          final PdfDocument document =
          PdfDocument(inputBytes: file.readAsBytesSync());
          text = PdfTextExtractor(document).extractText();
          document.dispose();
        } else {
          final bytes = file.readAsBytesSync();
          text = docxToText(bytes);
        }

        callGeminiAPI(text);
      } else print("Err");
    });
  }



  @override
Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Tiêu đề
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "TÓM TẮT VĂN BẢN",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Ô nhập văn bản
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
                              hintText: "Dán văn bản cần tóm tắt...",
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
                // Hoặc
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "- hoặc -",
                    style: TextStyle(color: AppColors.gray),
                  ),
                ),
                // Nút Upload
                FunctionButton(
                  onTap: _pickFile,
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
          // Nút tóm tắt đặt ở vị trí tùy chỉnh
          Positioned(
            top: 16.0, // Khoảng cách từ trên xuống
            right: 16.0, // Khoảng cách từ phải sang
            child: ElevatedButton(
              onPressed: () {
                print("Nút tóm tắt được nhấn");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Tóm tắt",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}
