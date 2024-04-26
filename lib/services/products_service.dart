import '../common_libs.dart';

class ProductsService with ChangeNotifier {
  ProductList get productListService => ProductListData.productsList;

  List<Product> get products => productListService.products;
}
