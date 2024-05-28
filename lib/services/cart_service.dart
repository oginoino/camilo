import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../common_libs.dart';

class CartService with ChangeNotifier {
  late ProductCart _productCart;
  bool isLoading = false;

  ProductCart get productCart => _productCart;

  Future<String?> _getToken() async {
    return await session.user?.getIdToken();
  }

  Uri _buildUri(String path) {
    final String baseUrl = dotenv.env['API_URL']!;
    return Uri.parse('$baseUrl$path');
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      _productCart = ProductCart.fromJson(data.first['data']);
      notifyListeners();
    } else {
      throw Exception('Failed to load product cart');
    }
  }

  Future<void> fetchProductCart() async {
    isLoading = true;
    notifyListeners();

    final Uri uri = _buildUri('/carts');
    final String? token = await _getToken();

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token',
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

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(productCart.toJson()),
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
