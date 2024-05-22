import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../common_libs.dart';
import '../models/predictions.dart';

class MapsService with ChangeNotifier {
  Predictions get predictions => _predictions;
  Predictions _predictions = Predictions([], '');
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchAddress(String input) async {
    isLoading = true;
    notifyListeners();
    final String baseUrl = dotenv.env['API_URL']!;

    final Uri uri = Uri.parse('$baseUrl?input=$input');

    try {
      final http.Response response = await http.get(uri);

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
    final Map<String, dynamic> data = jsonDecode(response.body);
    return Predictions.fromJson(data);
  }

  void _handleErrors(http.Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    Predictions predictions = Predictions.fromJson(json);
    if (predictions.hasError) {
      _predictions = Predictions([], predictions.status,
          errorMessage: predictions.errorMessage);
    } else {
      _predictions = Predictions([], 'ERROR');
    }
    notifyListeners();
  }

  void clearPredictions() {
    _predictions.predictions.clear();
    notifyListeners();
  }
}
