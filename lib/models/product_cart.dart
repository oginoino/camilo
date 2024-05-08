import '../common_libs.dart';

class ProductCart with ChangeNotifier {
  final List<Product> _cartProducts = [];

  List<List<Product>> get productsGruppedByProductId {
    List<List<Product>> productsGruppedByProductId = [];
    _cartProducts.sort((a, b) => a.id.compareTo(b.id));
    for (Product product in _cartProducts) {
      if (productsGruppedByProductId
          .any((element) => element.first.id == product.id)) {
        productsGruppedByProductId
            .firstWhere((element) => element.first.id == product.id)
            .add(product);
      } else {
        productsGruppedByProductId.add([product]);
      }
    }
    return productsGruppedByProductId;
  }

  List<Product> get cartProducts => _cartProducts;

  double get totalPrice => _cartProducts.fold(
      0.0, (previousValue, element) => previousValue + element.productPrice);

  bool get isMinimumOrder => totalPrice >= minimumOrder;

  double get minimumOrder => 10.0;

  void incrementProduct(BuildContext context, Product product) {
    int selectedQuantity = getSelectedQuantityByProductId(product.id);
    if (product.availableQuantity > selectedQuantity) {
      _cartProducts.add(product);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(' Só temos ${product.availableQuantity} unidades'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void decrementProduct(BuildContext context, Product product) {
    // where the product is in the cart
    int index = _cartProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _cartProducts.removeAt(index);
      notifyListeners();
    }
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }

  int getSelectedQuantityByProductId(String productId) {
    return _cartProducts
        .where((product) => product.id == productId)
        .fold(0, (previousValue, element) => previousValue + 1);
  }

  @override
  String toString() {
    return 'ProductCart{products: $products}';
  }
}
