import '../common_libs.dart';

class ProductCart with ChangeNotifier {
  ProductList products = ProductList(products: []);

  List<ProductList> get productsGruppedByProductId {
    List<ProductList> productsGruppedByProductId = [];
    for (Product product in products.products) {
      if (productsGruppedByProductId
          .any((element) => element.products.first.id == product.id)) {
        productsGruppedByProductId
            .firstWhere((element) => element.products.first.id == product.id)
            .addProduct(product);
      } else {
        productsGruppedByProductId.add(ProductList(products: [product]));
      }
    }
    return productsGruppedByProductId;
  }

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
