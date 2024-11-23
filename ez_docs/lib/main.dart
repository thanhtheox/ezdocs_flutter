import 'package:flutter/material.dart';
//import '../src/screens/Home/home.dart';
import '../src/screens/Summarize/sum.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SummaryScreen(),
    );
  }
  
}
