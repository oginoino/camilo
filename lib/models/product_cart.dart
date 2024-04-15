import '../common_libs.dart';

class ProductCart with ChangeNotifier {
  ProductList products = ProductList(products: []);

  int get totalProducts => products.products.length;

  void addProduct(Product product) {
    products.addProduct(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    products.removeProduct(product);
    notifyListeners();
  }

  void clearProducts() {
    products.clearProducts();
    notifyListeners();
  }

  void updateProduct(Product product) {
    products.updateProduct(product);
    notifyListeners();
  }

  @override
  String toString() {
    return 'ProductCart{products: $products}';
  }
}
