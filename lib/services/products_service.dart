import '../common_libs.dart';

class ProductsService with ChangeNotifier {
  ProductList get productListService {
    return ProductListData.productsList;
  }
}
