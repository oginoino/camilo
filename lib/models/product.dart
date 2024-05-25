import '../common_libs.dart';

class Product extends ChangeNotifier {
  final String id;
  final String productName;
  final double productPrice;
  final String productUnitOfMeasure;
  final String productUnitQuantity;
  final List<String> productCategories;
  final int availableQuantity;
  final String? contentValue;
  final String? productImageSrc;
  final double? producKilogramsWeight;
  final double? productCubicMeterVolume;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productUnitOfMeasure,
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
    return 'Product{id: $id, productName: $productName, productPrice: $productPrice, productUnitOfMeasurement: $productUnitOfMeasure, productUnitQuantity: $productUnitQuantity, contentValue: $contentValue, productImageSrc: $productImageSrc, productCategories: $productCategories, availableQuantity: $availableQuantity, producKilogramsWeight: $producKilogramsWeight, productCubicMeterVolume: $productCubicMeterVolume}';
  }

  // from json
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productPrice: (json['productPrice'] as num).toDouble(),
      productUnitOfMeasure: json['productUnitOfMeasure'],
      productUnitQuantity: json['productUnitQuantity'],
      productCategories: List<String>.from(json['productCategories']),
      availableQuantity: (json['availableQuantity'] as num).toInt(),
      contentValue: json['contentValue'],
      productImageSrc: json['productImageSrc'],
      producKilogramsWeight: (json['producKilogramsWeight'] as num).toDouble(),
      productCubicMeterVolume:
          (json['productCubicMeterVolume'] as num).toDouble(),
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'productUnitOfMeasure': productUnitOfMeasure,
      'productUnitQuantity': productUnitQuantity,
      'productCategories': productCategories,
      'availableQuantity': availableQuantity,
      'contentValue': contentValue,
      'productImageSrc': productImageSrc,
      'producKilogramsWeight': producKilogramsWeight,
      'productCubicMeterVolume': productCubicMeterVolume,
    };
  }
}
