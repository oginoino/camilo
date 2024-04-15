import 'package:camilo/common_libs.dart';

class ProductList extends ChangeNotifier {
  final List<Product> products;

  ProductList({required this.products});

  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    products.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    products.clear();
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productIndex = products.indexWhere((p) => p.id == product.id);
    products[productIndex] = product;
    notifyListeners();
  }

  @override
  String toString() {
    return 'ProductList{products: $products}';
  }
}
