import 'dart:convert';
import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';// Import the package

// Data model for the JSON data
class DataItem {
  final int id;
  final String key;
  final bool used;

  DataItem({required this.id, required this.key, required this.used});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      key: json['key'],
      used: json['used'] ?? true,
    );
  }

  Map<String, dynamic> toJson() => { // Add this method
    'id': id,
    'key': key,
    'used': used,
  };
}

  //bool isClosing = false;
  String apiKey = '';
  String inputText = '';
  String geminiOutput = '';
  bool isLoading = true;
  String? errorMessage;
  List<DataItem> dataItems = [];



  Future<void> fetchApiKey() async {
    try {
      // 1. Try loading from environment variables first (Recommended for production)
      //apiKey = const String.fromEnvironment('API_KEY');

      // 2. Fallback to fetching from JSON file if environment variable is not set
      if (apiKey.isEmpty) {
        final response =
        await http.get(Uri.parse('http://thbao.mooo.com/key.json')); // Replace with your JSON URL
        if (response.statusCode == 200) {
          try{
            final List<dynamic> jsonList = jsonDecode(response.body);
            dataItems = jsonList.map((item) => DataItem.fromJson(item)).toList();
            final targetItem = dataItems.firstWhere((item) => !item.used,
                orElse: () => throw Exception('No unused API keys found.'));
            final index = dataItems.indexOf(targetItem);
            if (index != -1) {
              dataItems[index] = DataItem(id: targetItem.id, key: targetItem.key, used: true);
            }
            apiKey = targetItem.key;
            print(apiKey);}
          catch (decodeError) {
            // Handle JSON decoding errors specifically
            print('Error decoding JSON: $decodeError');
            print('Raw JSON response: ${response.body}'); // Print raw JSON for debugging
          }
          try {
            final response = await http.post(
              Uri.parse('http://thbao.mooo.com/be.php'),
              body: jsonEncode(dataItems), // Send the updated list
              headers: {'Content-Type': 'application/json'},

            );
            print(response.statusCode);
            if (response.statusCode == 200 || response.statusCode == 204) {
              print('JSON updated successfully');
            } else {
              throw Exception(
                  'Failed to update JSON file: ${response.statusCode} ${response.body}');
            }
          } catch (e) {
            // Handle error during update. Maybe log the error, inform the user, etc.

            print('Error updating JSON: $e'); // Log the error at least.

          }
        } else {
          throw Exception('Failed to load API key from JSON');
        }
      }
    } catch (e) {
        errorMessage = 'Error: $e';
    } finally {
        isLoading = false;
    }
  }
Future<void> resetUsedStatus() async {
  // setState(() {
  //   isClosing = true; //Show closing indicator.
  // });
  try {
    if (apiKey.isNotEmpty) {
      final usedItem = dataItems.firstWhere(
              (item) => item.key == apiKey,
          orElse: () => throw Exception('Used API key not found in list'));


      final index = dataItems.indexOf(usedItem);
      dataItems[index] = DataItem(
          id: usedItem.id, key: usedItem.key, used: false); // Set used to false


      final response = await http.post(
        Uri.parse('http://thbao.mooo.com/be.php'),
        body: jsonEncode(dataItems),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        // setState(() {
        //   isClosing = false;
        // });
        throw Exception('Failed to reset used status in JSON ${response.statusCode} ${response.body}'); // Log the error, inform user, or take other action
      }
    }
  } catch (e) {
    // setState(() {
    //   isClosing = false;
    // });
    print('Failed to reset used status: $e');

  }
}

  // Future<bool> _handlePop(Route<dynamic> route) async {
  //   if(isClosing){
  //     return false;
  //   }
  //
  //   final shouldReset = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Reset API Key'),
  //       content: const Text(
  //           'Do you want to end this session? Your progress will not be recorded.'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: const Text('No'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: const Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   );
  //   if (shouldReset == true) {
  //
  //     await _resetUsedStatus();
  //   } else {
  //     // If the user clicks no, just exit the app on windows.
  //     if (Platform.isWindows) {
  //       exit(0);
  //     }
  //     //Handle closing behavior on other platforms if necessary.
  //
  //   }
  //   return false; // Prevent default pop behavior; we handle exiting manually.
  //
  //
  // }

  // Future<void> callGeminiAPI() async {
  //   if (apiKey.isEmpty) {
  //     // Handle the case where the API key is not available
  //       errorMessage = 'API key is missing.';
  //     return;
  //   }
  //
  //     isLoading = true;
  //     errorMessage = null;
  //
  //   try {
  //     final model = GenerativeModel(
  //       model: 'gemini-1.5-pro-002',
  //       apiKey: apiKey,
  //     );
  //     String prompt = inputText.isEmpty ? 'Testing 1 2 3' : inputText;
  //
  //     final response = await model.generateContent([Content.text(prompt)]) ;
  //     geminiOutput = response.text ?? "There is an error, somehow";
  //   } catch (e) {
  //       errorMessage = 'Error: $e';
  //   } finally {
  //       isLoading = false;
  //   }
  // }
