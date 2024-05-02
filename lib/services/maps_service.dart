import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../common_libs.dart';
import '../models/predictions.dart';

class MapsService with ChangeNotifier {
  String language = 'pt';
  String key = dotenv.env['M_API_KEY'] ?? '';
  String path = 'https://maps.googleapis.com/maps/api/place/queryautocomplete/json';

  Predictions get predictions => _predictions;
  Predictions _predictions = Predictions([], '');
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchAddress(String input) async {
    isLoading = true;
    notifyListeners();

    final uri = Uri.parse(path).replace(
        queryParameters: {'language': language, 'input': input, 'key': key});

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        _predictions = _handleSuccess(response);
        errorMessage = null;
      } else {
        _handleErrors(response);
      }
    } catch (e) {
      errorMessage = "Failed to fetch data: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Predictions _handleSuccess(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Predictions.fromJson(json);
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode == 404) {
      errorMessage = 'Not found: ${response.body}';
    } else if (response.statusCode >= 500) {
      errorMessage = 'Server error: ${response.body}';
    } else {
      errorMessage = 'Unexpected response: ${response.body}';
    }
    _predictions = Predictions([], '');
  }
}
