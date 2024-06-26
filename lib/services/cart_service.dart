import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../common_libs.dart';

class CartService with ChangeNotifier {
  late ProductCart _productCart;
  bool isLoading = false;

  CartService(ProductCart productCart) {
    _productCart = productCart;
    _initializeCart();
  }

  ProductCart get productCart => _productCart;

  Future<void> _initializeCart() async {
    if (session.user != null) {
      await fetchProductCart();
    }
  }

  Future<String?> _getToken() async {
    return await session.user?.getIdToken(true);
  }

  Uri _buildUri(String path) {
    final String baseUrl = dotenv.env['API_URL']!;
    return Uri.parse('$baseUrl$path');
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        final extractedData = json.decode(utf8.decode(response.bodyBytes));
        _productCart.updateCartItems(
          ProductCart.fromJson(extractedData['data']).cartProducts,
        );
        notifyListeners();
      } catch (e) {
        _productCart.clearCart(); // Clear cart on parsing error
        notifyListeners();
        throw Exception('Failed to parse product cart');
      }
    } else {
      _productCart.clearCart(); // Clear cart on non-200 status code
      notifyListeners();
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
      isLoading = false;
      notifyListeners();
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
      _productCart.clearCart();
      notifyListeners();
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
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final response = await _sendPutRequest(uri, token, productCart);
      _handleResponse(response);
    } catch (e) {
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _sendPutRequest(
      Uri uri, String token, ProductCart productCart) async {
    var response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      },
      body: jsonEncode({
        'productsItems': productCart.cartProducts.map((product) {
          return {
            'productId': product.productId,
            'selectedQuantity': product.selectedQuantity,
            'product': product.product.toJson(),
          };
        }).toList(),
      }),
    );

    if (response.statusCode == 307) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        Uri newUri;
        if (redirectUrl.startsWith('/')) {
          newUri = Uri.parse(uri.origin + redirectUrl);
        } else {
          newUri = Uri.parse(redirectUrl);
        }
        response = await http.put(
          newUri,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': token,
          },
          body: jsonEncode({
            'productsItems': productCart.cartProducts.map((product) {
              return {
                'productId': product.productId,
                'selectedQuantity': product.selectedQuantity,
                'product': product.product.toJson(),
              };
            }).toList(),
          }),
        );
      }
    }
    return response;
  }

  Future<void> syncCartAfterLogin() async {
    if (session.user != null) {
      productCart.cartProducts.isEmpty
          ? await fetchProductCart()
          : await updateProductCart(productCart);
      notifyListeners();
    }
  }

  Future<void> syncCart(ProductCart productCart) async {
    if (session.user != null) {
      await updateProductCart(productCart);
    }
  }
}
