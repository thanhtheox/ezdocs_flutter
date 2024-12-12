import 'package:ez_docs/src/screens/Chatbot/chatbot.dart';
import 'package:ez_docs/src/screens/Translation/translate.dart';
import 'package:ez_docs/src/screens/Translation/translateResult.dart';
import 'package:flutter/material.dart';
import 'package:ez_docs/src/screens/Home/home.dart';
import 'package:ez_docs/src/screens/Summary/sum.dart';
import 'package:ez_docs/src/screens/Summary/sumResult.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;
    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/Summarize':
        return MaterialPageRoute(builder: (_) => const SummaryScreen());
      case '/SummarizeResult':
        return MaterialPageRoute(builder: (_) => const SummaryResultScreen());
      case '/Translation':
        return MaterialPageRoute(builder: (_) => const TranslationScreen());
      case '/TranslationResult':
        return MaterialPageRoute(builder: (_) => const TranslationResultScreen());
      case '/Chatbot':
        return MaterialPageRoute(builder: (_) => const ChatbotScreen());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}