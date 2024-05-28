import '../common_libs.dart';

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
      selectedQuantity: json['selectedQuantity'],
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
