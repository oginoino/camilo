import '../common_libs.dart';

class ProductList extends ChangeNotifier {
  List<Product> products;

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

  void clearProductSelectedQuantity() {
    for (final product in products) {
      product.selectedQuantity = 0;
    }
    notifyListeners();
  }

  void updateProduct(Product product) {
    final productIndex = products.indexWhere((p) => p.id == product.id);
    products[productIndex] = product;
    notifyListeners();
  }

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
          (product) => product.productName.toLowerCase().contains(
                value.toLowerCase(),
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
