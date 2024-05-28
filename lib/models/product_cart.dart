import '../common_libs.dart';
import '../services/cart_service.dart';

class ProductCart with ChangeNotifier {
  ProductCart();

  final List<ProductItem> _cartProducts = [];

  List<List<ProductItem>> get productsGruppedByProductId {
    List<List<ProductItem>> productsGruppedByProductId = [];
    _cartProducts.sort((a, b) => a.productId.compareTo(b.productId));
    for (ProductItem productItem in _cartProducts) {
      if (productsGruppedByProductId
          .any((element) => element.first.productId == productItem.productId)) {
        productsGruppedByProductId
            .firstWhere(
                (element) => element.first.productId == productItem.productId)
            .add(productItem);
      } else {
        productsGruppedByProductId.add([productItem]);
      }
    }
    return productsGruppedByProductId;
  }

  List<ProductItem> get cartProducts => _cartProducts;

  double get totalPrice => _cartProducts.fold(
      0.0,
      (previousValue, element) =>
          previousValue +
          (element.product.productPrice * element.selectedQuantity));

  bool get isMinimumOrder => totalPrice >= minimumOrder;

  double get minimumOrder => 10.0;

  void incrementProduct(BuildContext context, Product product) {
    int selectedQuantity = getSelectedQuantityByProductId(product.id);
    if (product.availableQuantity > selectedQuantity) {
      _cartProducts.add(ProductItem(
        productId: product.id,
        product: product,
        selectedQuantity: 1,
      ));
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Só temos ${product.availableQuantity} unidades'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void decrementProduct(BuildContext context, Product product) {
    int index =
        _cartProducts.indexWhere((element) => element.productId == product.id);
    if (index != -1) {
      if (_cartProducts[index].selectedQuantity > 1) {
        _cartProducts[index].selectedQuantity--;
      } else {
        _cartProducts.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }

  int getSelectedQuantityByProductId(String productId) {
    return _cartProducts
        .where((productItem) => productItem.productId == productId)
        .fold(
            0,
            (previousValue, element) =>
                previousValue + element.selectedQuantity);
  }

  @override
  String toString() {
    return 'ProductCart{products: $cartProducts}';
  }

  // from json
  ProductCart.fromJson(Map<String, dynamic> json) {
    if (json['productsItems'] != null) {
      json['productsItems'].forEach((product) {
        _cartProducts.add(ProductItem.fromJson(product));
      });
    }
  }

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productsItems'] =
        _cartProducts.map((product) => product.toJson()).toList();
    return data;
  }

  // Métodos de sincronização conforme os cenários BDD
  void syncCartWithBackend(CartService cartService) async {
    if (session.user != null) {
      await cartService.syncCart(this);
      notifyListeners();
    }
  }

  void addProductAndSync(
      BuildContext context, CartService cartService, Product product) {
    incrementProduct(context, product);
    syncCartWithBackend(cartService);
  }

  void removeProductAndSync(
      BuildContext context, CartService cartService, Product product) {
    decrementProduct(context, product);
    syncCartWithBackend(cartService);
  }

  void clearCartAndSync(CartService cartService) {
    clearCart();
    syncCartWithBackend(cartService);
  }

  void updateQuantityAndSync(BuildContext context, CartService cartService,
      Product product, int quantity) {
    int index =
        _cartProducts.indexWhere((element) => element.productId == product.id);
    if (index != -1) {
      _cartProducts[index].selectedQuantity = quantity;
      notifyListeners();
      syncCartWithBackend(cartService);
    }
  }
}

class ProductItem {
  final String productId;
  final Product product;
  int selectedQuantity;

  ProductItem({
    required this.productId,
    required this.product,
    required this.selectedQuantity,
  });

  @override
  String toString() {
    return 'ProductItem{productId: $productId, product: $product, selectedQuantity: $selectedQuantity}';
  }

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      productId: json['productId'],
      product: Product.fromJson(json['product']),
      selectedQuantity: (json['selectedQuantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'product': product.toJson(),
      'selectedQuantity': selectedQuantity,
    };
  }
}
