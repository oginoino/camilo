class Product {
  final String id;
  final String productName;
  final double productPrice;
  final String productUnitOfMeasurement;
  final String productUnitQuantity;
  final String? productImageSrc;
  int selectedQuantity;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productUnitOfMeasurement,
    required this.productUnitQuantity,
    this.productImageSrc,
    this.selectedQuantity = 0,
  });

  void incrementQuantity() {
    selectedQuantity++;
  }

  void decrementQuantity() {
    if (selectedQuantity > 0) {
      selectedQuantity--;
    }
  }
}
