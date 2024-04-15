import '../common_libs.dart';

class Product extends ChangeNotifier {
  final String id;
  final String productName;
  final double productPrice;
  final String productUnitOfMeasurement;
  final String productUnitQuantity;
  final String? productImageSrc;
  int selectedQuantity;
  final List<String> productCategories;
  final int availableQuantity;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productUnitOfMeasurement,
    required this.productUnitQuantity,
    this.productImageSrc,
    this.selectedQuantity = 0,
    required this.productCategories,
    required this.availableQuantity,
  });

  void incrementQuantity() {
    selectedQuantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (selectedQuantity > 0) {
      selectedQuantity--;
      notifyListeners();
    }
  }

  void resetQuantity() {
    selectedQuantity = 0;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, productPrice: $productPrice, productUnitOfMeasurement: $productUnitOfMeasurement, productUnitQuantity: $productUnitQuantity, productImageSrc: $productImageSrc, selectedQuantity: $selectedQuantity, productCategories: $productCategories}';
  }
}
