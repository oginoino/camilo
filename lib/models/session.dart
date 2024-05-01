import '../common_libs.dart';

class Session with ChangeNotifier {
  bool isAuthenticated = false;

  void setAuthenticating(bool value) {
    isAuthenticated = value;
    notifyListeners();
  }

  void logout() {
    isAuthenticated = false;
    appRouter.go(ScreenPaths.home);
    notifyListeners();
  }
}
