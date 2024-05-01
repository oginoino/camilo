import '../common_libs.dart';

class Session with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void logout() {
    _isAuthenticated = false;
    appRouter.go(ScreenPaths.home);
    notifyListeners();
  }

  void login({required String email, required String password}) {
    _isAuthenticated = true;
    notifyListeners();
  }

  void register(
      {required String name, required String email, required String password}) {
    _isAuthenticated = true;
    notifyListeners();
  }
}
