import '../common_libs.dart';

class Product extends ChangeNotifier {
  final String id;
  final String productName;
  final double productPrice;
  final String productUnitOfMeasurement;
  final String productUnitQuantity;
  final String? contentValue;
  final String? productImageSrc;

  final List<String> productCategories;
  final int availableQuantity;
  final double? producKilogramsWeight;
  final double? productCubicMeterVolume;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productUnitOfMeasurement,
    required this.productUnitQuantity,
    this.contentValue,
    this.productImageSrc,
    required this.productCategories,
    required this.availableQuantity,
    this.producKilogramsWeight = 0.3,
    this.productCubicMeterVolume = 0.0001,
  });

  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, productPrice: $productPrice, productUnitOfMeasurement: $productUnitOfMeasurement, productUnitQuantity: $productUnitQuantity, contentValue: $contentValue, productImageSrc: $productImageSrc, productCategories: $productCategories, availableQuantity: $availableQuantity, producKilogramsWeight: $producKilogramsWeight, productCubicMeterVolume: $productCubicMeterVolume}';
  }
}
