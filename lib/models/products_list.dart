import '../common_libs.dart';

class ProductList extends ChangeNotifier {
  List<Product> products;

  ProductList({required this.products});

  void getProductsByCategory(String category) {
    products.where((product) => product.productCategories.contains(category));
    notifyListeners();
  }

  @override
  String toString() {
    return 'ProductList{products: $products}';
  }

  Product getProductById(String id) {
    return products.firstWhere((product) => product.id == id);
  }

  void searchProducts(String value) {
    products = productsService.productListService.products
        .where(
          (product) =>
              product.productName.toLowerCase().ignoreAccents().contains(
                    value.toLowerCase().ignoreAccents(),
                  ),
        )
        .toList();
    notifyListeners();
  }

  void getAllProducts() {
    products = productsService.productListService.products;
    notifyListeners();
  }
}

extension StringExtension on String {
  String ignoreAccents() {
    return replaceAll('á', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('à', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ç', 'c')
        .replaceAll('\'', '')
        .replaceAll('-', '');
  }
}
