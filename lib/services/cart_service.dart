import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../common_libs.dart';

class CartService with ChangeNotifier {
  bool isLoading = false;
  late List<ProductItem> _productItems = [];

  List<ProductItem> get productItems => _productItems;

  Future<void> createOrUpdateCart(ProductCart productCart) async {
    isLoading = true;
    notifyListeners();

    final String baseUrl = dotenv.env['API_URL']!;
    const String path = '/carts';
    final Uri uri = Uri.parse('$baseUrl$path');
    String? token = await session.user?.getIdToken(true);

    final List<List<ProductItem>> groupedProducts =
        productCart.productsGruppedByProductId;
    List<ProductItem> productItems = [];

    for (var group in groupedProducts) {
      if (group.isNotEmpty) {
        int totalQuantity =
            group.fold(0, (sum, item) => sum + item.selectedQuantity);
        productItems.add(ProductItem(
          productId: group.first.productId,
          product: group.first.product,
          selectedQuantity: totalQuantity,
        ));
      }
    }

    final newCart = {
      'productItems': productItems.map((item) => item.toJson()).toList(),
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
      body: json.encode(newCart),
    );

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final extractedData = json.decode(utf8.decode(response.bodyBytes));
        _productItems = (extractedData['productItems'] as List)
            .map((item) => ProductItem.fromJson(item))
            .toList();
      } else {
        throw Exception('Falha ao atualizar o carrinho');
      }
    } catch (error) {
      // Adicione qualquer tratamento de erro necessário aqui
      _productItems = [];
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
