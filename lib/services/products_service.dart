import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../common_libs.dart';
import 'package:http/http.dart' as http;

class ProductsService with ChangeNotifier {
  List<Product> _productList = [];
  List<Product> get productListService => _productList;
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    final String baseUrl = dotenv.env['API_URL']!;

    const String path = '/products';

    final Uri uri = Uri.parse('$baseUrl$path');

    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    final List<dynamic> extractedData = json.decode(response.body);
    final List<Product> loadedProducts = [];
    for (var productData in extractedData) {
      loadedProducts.add(Product.fromJson(productData));
    }
    _productList = loadedProducts;
    debugPrint('$_productList');
    isLoading = false;
    notifyListeners();
  }
}
