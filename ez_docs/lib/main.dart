import 'package:ez_docs/src/repos/main_links.dart';
import 'package:ez_docs/src/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'route_generator.dart';
//import '../src/screens/Home/home.dart';
import '../src/screens/Summarize/sum.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    super.initState();
    fetchApiKey();
  }

  @override
  void dispose() {
    super.dispose();
    resetUsedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const HomeScreen(),
    );
  }
  
}
