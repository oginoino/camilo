import '../common_libs.dart';

class Section with ChangeNotifier {
  bool isAuthenticated = false;

  void setAuthenticating(bool value) {
    isAuthenticated = value;
    notifyListeners();
  }
}
