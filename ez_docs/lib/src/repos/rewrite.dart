//import 'dart:io';
import 'dart:typed_data';

//import 'package:flutter/material.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'main_links.dart';



Future<String> callGeminiAPI(String doc, [String? mod]) async {
  if (apiKey.isEmpty || attempts >= 50) {
    print("Try again");
    fetchApiKey();
    callGeminiAPI(doc);
  }

  isLoading = true;
  errorMessage = null;
  print("Starting");

  try {
    attempts++;
    print("gg");
    updateUsedStatus(true, null, attempts);
    print("ggg");
    final model = GenerativeModel(
      model: mod ?? 'gemini-1.5-flash-8b',
      apiKey: apiKey,
    );
    print("model dne");
    String prompt = 'Testing 1 2 3 \n$doc\ncan you read it?. Please return a rewritten version of it';

    final response = await model.generateContent([Content.text(prompt)]) ;
    geminiOutput = response.text ?? "There is an error, somehow";
    print(geminiOutput);
    return geminiOutput;
  } catch (e) {
      errorMessage = 'Error: $e';
      print(errorMessage);
      rethrow;
  } finally {
    updateUsedStatus(false, null, attempts);
    isLoading = false;

  }
}