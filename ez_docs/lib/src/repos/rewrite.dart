import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_generative_ai/google_generative_ai.dart';

import 'main_links.dart';

Future<void> callGeminiAPI(Uint8List files) async {
  if (apiKey.isEmpty) {
    // Handle the case where the API key is not available
    errorMessage = 'API key is missing.';
    return;
  }

  isLoading = true;
  errorMessage = null;
  print("Starting");

  try {
    final model = GenerativeModel(
      model: 'gemini-1.5-pro-002',
      apiKey: apiKey,
    );
    print("model dne");
    TextPart prompt = TextPart(inputText.isEmpty ? 'Testing 1 2 3 ' : inputText);
    print("fin");
    final dataPart = [DataPart('image/jpeg', files)];
    print("done1");
    final response = await model.generateContent([Content.multi([prompt, ...dataPart])]) ;
    print("object");
    geminiOutput = response.text ?? "There is an error, somehow";
    print(geminiOutput);
  } catch (e) {
    errorMessage = 'Error: $e';
  } finally {
    isLoading = false;
  }
}