import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/predictions.dart';

class ApiService {
  String language = 'pt';
  String key = '${dotenv.env['M_API_KEI']}';
  String path =
      'https://maps.googleapis.com/maps/api/place/queryautocomplete/json';

  Future<Predictions> fetchAddress(String input) async {
    Map<String, String> headers = {
      'Accept': '*/*',
      'Host': 'https://maps.googleapis.com',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
    };

    final response = await http.get(
      Uri.parse('$path?language=$language&input=$input&key=$key'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return _handleSuccess(response);
    } else if (response.statusCode == 404) {
      return _handleNotFound(response);
    } else if (response.statusCode >= 500) {
      return _handleServerError(response);
    } else {
      return _handleOtherResponses(response);
    }
  }

  Predictions _handleSuccess(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Predictions.fromJson(json);
  }

  Predictions _handleNotFound(http.Response response) {
    throw Exception('Not found: ${response.body}');
  }

  Predictions _handleServerError(http.Response response) {
    throw Exception('Server error: ${response.body}');
  }

  Predictions _handleOtherResponses(http.Response response) {
    throw Exception('Unexpected response: ${response.body}');
  }
}
