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
