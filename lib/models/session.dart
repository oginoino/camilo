import 'dart:math';

import 'package:camilo/models/user.dart';

import '../common_libs.dart';

class Session with ChangeNotifier {
  User? _user;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  User? get user => _user;

  void logout() {
    _isAuthenticated = false;
    _user = null;
    appRouter.go(ScreenPaths.home);
    notifyListeners();
  }

  void login({required String email, required String password}) {
    _user = User(
      uid: Random().nextInt(100).toString(),
      displayName: 'John Doe',
      userEmail: email,
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  void register(
      {required String name, required String email, required String password}) {
    _user = User(
      uid: Random().nextInt(100).toString(),
      displayName: name,
      userEmail: email,
    );
    _isAuthenticated = true;
    notifyListeners();
  }
}
