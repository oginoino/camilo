import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../common_libs.dart';
import '../models/predictions.dart';

class MapsService with ChangeNotifier {
  String language = 'pt';
  String key = '${dotenv.env['M_API_KEI']}';
  String path =
      'https://maps.googleapis.com/maps/api/place/queryautocomplete/json';

  Predictions get predictions => _predictions;

  Predictions _predictions = Predictions([], '');

  fetchAddress(String input) async {
    final response = await http.get(
      Uri.parse('$path?language=$language&input=$input&key=$key'),
    );

    if (response.statusCode == 200) {
      _predictions = _handleSuccess(response);
    } else if (response.statusCode == 404) {
      _handleNotFound(response);
    } else if (response.statusCode >= 500) {
      _handleServerError(response);
    } else {
      _handleOtherResponses(response);
    }
  }

  Predictions _handleSuccess(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Predictions.fromJson(json);
  }

  _handleNotFound(http.Response response) {
    throw Exception('Not found: ${response.body}');
  }

  _handleServerError(http.Response response) {
    throw Exception('Server error: ${response.body}');
  }

  _handleOtherResponses(http.Response response) {
    throw Exception('Unexpected response: ${response.body}');
  }
}
