import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../common_libs.dart';

class AppLogic {
  bool isBootstrapComplete = false;

  Future<void> bootstrap() async {
    await dotenv.load(fileName: ".env");

    products.getAllProducts();

    if (session.user != null) {
      await cartService.syncCartAfterLogin();
    }

    isBootstrapComplete = true;
  }
}
