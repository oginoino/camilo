import '../common_libs.dart';

class ProductCart with ChangeNotifier {
  ProductList products = ProductList(products: []);

  int get totalProducts => products.products.length;

  double get totalPrice => products.products.fold(
      0.0, (previousValue, element) => previousValue + element.productPrice);

  bool get isMinimumOrder => totalPrice >= minimumOrder;

  double get minimumOrder => 10.0;

  void addProduct(Product product) {
    if (product.selectedQuantity < product.availableQuantity) {
      products.addProduct(product);
      notifyListeners();
    }

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
