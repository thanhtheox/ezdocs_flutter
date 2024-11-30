import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io' show Platform, exit;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';// Import the package

// Data model for the JSON data
class DataItem {
  final int id;
  final String key;
  final bool used;
  final String lastUsed;
  final int attempts;

  DataItem({required this.id, required this.key, required this.used, required this.lastUsed, required this.attempts});

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      key: json['key'],
      used: json['used'] ?? true,
      lastUsed: json['lastUsed'] ?? "2024-08-08T10:30:00-04:00",
      attempts:json['attempts'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => { // Add this method
    'id': id,
    'key': key,
    'used': used,
    'lastUsed' : lastUsed,
    'attempts' : attempts,
  };
}

  //bool isClosing = false;
  String apiKey = '';
  String inputText = '';
  String geminiOutput = '';
  bool isLoading = true;
  String? errorMessage;
  List<DataItem> dataItems = [];
  late int attempts;



  Future<void> fetchApiKey() async {
    dataItems = [];
    try {
      // 1. Try loading from environment variables first (Recommended for production)
      //apiKey = const String.fromEnvironment('API_KEY');

      // 2. Fallback to fetching from JSON file if environment variable is not set
      if (apiKey.isEmpty || attempts >=50) {
        final response =
        await http.get(Uri.parse('http://thbao.mooo.com/key.json')); // Replace with your JSON URL
        if (response.statusCode == 200) {
          try{
            final List<dynamic> jsonList = jsonDecode(response.body);
            dataItems = jsonList.map((item) => DataItem.fromJson(item)).toList();
            final targetItem = dataItems.firstWhere((item) => !item.used && ((DateTime.now().difference(DateTime.parse(item.lastUsed)) >= const Duration(hours: 18)) || item.attempts <= 49),
                orElse: () => throw Exception('No unused API keys found.'));
            final index = dataItems.indexOf(targetItem);
            if (index != -1) {
              if(DateTime.now().difference(DateTime.parse(targetItem.lastUsed)) >= const Duration(hours: 18))
                dataItems[index] = DataItem(id: targetItem.id, key: targetItem.key, used: true, lastUsed: DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()),attempts: 0);
              else
                dataItems[index] = DataItem(id: targetItem.id, key: targetItem.key, used: true, lastUsed: DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime.now()),attempts: targetItem.attempts);
            }
            apiKey = targetItem.key;
            attempts = targetItem.attempts;
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
Future<void> updateUsedStatus(bool status, String? uLast, int uAttempts) async {
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
          id: usedItem.id,key: usedItem.key, used: status, lastUsed: uLast ?? usedItem.lastUsed, attempts: uAttempts); // Set used to false


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
