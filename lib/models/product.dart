class Product {
  final String id;
  final String productCode;
  final String productName;
  final double productPrice;
  final String productUnitOfMeasure;
  final String productUnitQuantity;
  final List<String> productCategories;
  final int availableQuantity;
  final String contentValue;
  final String productImageSrc;
  final double producKilogramsWeight;
  final double productCubicMeterVolume;
  final bool isActivated;

  Product({
    required this.id,
    required this.productCode,
    required this.productName,
    required this.productPrice,
    required this.productUnitOfMeasure,
    required this.productUnitQuantity,
    required this.productCategories,
    required this.availableQuantity,
    required this.contentValue,
    required this.productImageSrc,
    required this.producKilogramsWeight,
    required this.productCubicMeterVolume,
    required this.isActivated,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productCode: json['productCode'],
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
      isActivated: json['isActivated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productCode': productCode,
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
      'isActivated': isActivated,
    };
  }
}
