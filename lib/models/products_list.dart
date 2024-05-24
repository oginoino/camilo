import '../common_libs.dart';

class ProductList extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  List<String> get categories => _products
      .map((product) => product.productCategories)
      .expand((element) => element)
      .toSet()
      .toList();

  @override
  String toString() {
    return 'ProductList{products: $products}';
  }

  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void getProductsByCategory(String category) {
    _products.where((product) => product.productCategories.contains(category));
    notifyListeners();
  }

  void searchProducts(String value) {
    if (value.isEmpty) {
      _products = productsService.productListService;
      notifyListeners();
      return;
    } else {
      _products = productsService.productListService
          .where(
            (product) =>
                product.productName.toLowerCase().ignoreAccents().contains(
                      value.toLowerCase().ignoreAccents(),
                    ),
          )
          .toList();
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> getAllProducts() async {
    await productsService.fetchProducts();
    _products = productsService.productListService;
    notifyListeners();
  }
}

extension StringExtension on String {
  String ignoreAccents() {
    return replaceAll('á', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ä', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ç', 'c')
        .replaceAll('\'', '')
        .replaceAll('-', '');
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
