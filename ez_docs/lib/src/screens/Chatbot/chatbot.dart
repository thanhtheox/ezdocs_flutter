import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:ez_docs/src/repos/main_links.dart';
import 'package:ez_docs/src/repos/rewrite.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../components/header.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(id: "1", firstName: "Gemini");
  
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: CustomAppBar(
        activeTab: "Chatbot",
        onHelpTap: () {
          print("Nút trợ giúp được nhấn");
        },
        onTabSelected: (selectedTab) {
          print("Tab được chọn: $selectedTab");
        },
      ),
      body: DashChat(inputOptions: isLoading ? InputOptions(trailing: [CircularProgressIndicator()]) : InputOptions(trailing: [
        SizedBox()
      ]),
          currentUser: currentUser, onSend: _sendMessage, messages: messages),
    );
  }
  Future<void> _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
      isLoading = true;
    });
    try {
      String question = chatMessage.text;
      attempts++;
      print("gg");
      updateUsedStatus(true, null, attempts);
      print("ggg");
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-8b',
        apiKey: apiKey,
      );
      print("model dne");

      final response = await model.generateContent([Content.text(question)]);
      ChatMessage message = ChatMessage(user: geminiUser, createdAt: DateTime.now(),text: response.text ?? "Error",);
      setState(() {
        messages = [message,...messages];
        isLoading = false;
      });
    } catch(e) {
      print(e);
    }
  }
}