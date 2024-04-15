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

  void incrementSelectedQuantity(BuildContext context) {
    if (selectedQuantity < availableQuantity) {
      selectedQuantity++;
      notifyListeners();
    } else {
      String message = 'Só temos $availableQuantity desse produto no momento!';
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                ),
                duration: const Duration(seconds: 2),
              ),
            )
          : null;
    }
    notifyListeners();
  }

  void decrementSelectedQuantity(BuildContext context) {
    if (selectedQuantity > 0) {
      selectedQuantity--;
      notifyListeners();
    }
  }

  void resetSelectedQuantity() {
    selectedQuantity = 0;
    notifyListeners();
  }

  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, productPrice: $productPrice, productUnitOfMeasurement: $productUnitOfMeasurement, productUnitQuantity: $productUnitQuantity, productImageSrc: $productImageSrc, selectedQuantity: $selectedQuantity, productCategories: $productCategories}';
  }
}
