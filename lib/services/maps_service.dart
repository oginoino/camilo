import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../common_libs.dart';
import '../models/predictions.dart';

class MapsService with ChangeNotifier {
  String language = 'pt';
  String key = dotenv.env['M_API_KEY'] ?? '';
  String path =
      'https://maps.googleapis.com/maps/api/place/queryautocomplete/json';

  Predictions get predictions => _predictions;
  Predictions _predictions = Predictions([], '');

  Future<void> fetchAddress(String input) async {
    final uri = Uri.parse(path).replace(
        queryParameters: {'language': language, 'input': input, 'key': key});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      _predictions = _handleSuccess(response);
      notifyListeners();
    } else {
      _handleErrors(response);
    }
  }

  Predictions _handleSuccess(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Predictions.fromJson(json);
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode == 404) {
      throw Exception('Not found: ${response.body}');
    } else if (response.statusCode >= 500) {
      throw Exception('Server error: ${response.body}');
    } else {
      throw Exception('Unexpected response: ${response.body}');
    }
  }
}
