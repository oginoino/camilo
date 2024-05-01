import '../common_libs.dart';

class AppLogic {
  bool isBootstrapComplete = false;

  Future<void> bootstrap() async {
    products.getAllProducts();
    // Flag bootStrap as complete
    isBootstrapComplete = true;
  }
}
