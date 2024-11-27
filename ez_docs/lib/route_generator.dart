import 'package:flutter/material.dart';
import 'package:ez_docs/src/screens/Home/home.dart';
import 'package:ez_docs/src/screens/Summary/sum.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/Summarize':
        return MaterialPageRoute(builder: (_) => SummaryScreen());
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}