import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http; // Import the dart:convert package
import '../common_libs.dart';

class CartService with ChangeNotifier {
  late ProductCart _productCart;
  bool isLoading = false;

  CartService() {
    _productCart = ProductCart();
  }

  ProductCart get productCart => _productCart;

  Future<String?> _getToken() async {
    return await session.user?.getIdToken(true);
  }

  Uri _buildUri(String path) {
    final String baseUrl = dotenv.env['API_URL']!;
    return Uri.parse('$baseUrl$path');
  }

  void _handleResponse(http.Response response) {
    debugPrint('Response status code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    if (response.statusCode == 200) {
      try {
        final extractedData = json.decode(utf8.decode(response.bodyBytes));
        _productCart = ProductCart.fromJson(extractedData['data']);
        notifyListeners();
      } catch (e) {
        debugPrint('Error parsing product cart: $e');
        throw Exception('Failed to parse product cart');
      }
    } else {
      throw Exception(
          'Failed to load product cart with status code ${response.statusCode}');
    }
  }

  Future<void> fetchProductCart() async {
    isLoading = true;
    notifyListeners();

    final Uri uri = _buildUri('/carts');
    final String? token = await _getToken();

    if (token == null) {
      debugPrint('Token is null');
      return;
    }

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      _handleResponse(response);
    } catch (e) {
      debugPrint('Error fetching product cart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProductCart(ProductCart productCart) async {
    isLoading = true;
    notifyListeners();

    final Uri uri = _buildUri('/carts');
    final String? token = await _getToken();

    if (token == null) {
      debugPrint('Token is null');
      return;
    }

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
        body: jsonEncode(
          productCart.toJson(),
        ), // Use jsonEncode to encode the data
      );
      _handleResponse(response);
    } catch (e) {
      debugPrint('Error updating product cart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> syncCartAfterLogin() async {
    if (session.user != null) {
      await fetchProductCart();
      notifyListeners();
    }
  }

  Future<void> syncCart(ProductCart productCart) async {
    if (session.user != null) {
      await updateProductCart(productCart);
    }
  }
}
