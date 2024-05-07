import '../common_libs.dart';

class Session with ChangeNotifier {
  User? _user;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  User? get user => _user;

  Address? get selectedAddress => _selectedAddress;

  Address? _selectedAddress;

  void logout() {
    _isAuthenticated = false;
    _user = null;
    appRouter.go(ScreenPaths.home);
    notifyListeners();
  }

  void login({required String email, required String password}) {
    _user = User(
      uid: Random().nextInt(100).toString(),
      userEmail: email,
      displayName: 'Usuário',
      selectedAddress: _selectedAddress,
    );
    _user?.addAddress(_selectedAddress!);
    _isAuthenticated = true;
    notifyListeners();
  }

  void register(
      {required String name, required String email, required String password}) {
    _user = User(
      uid: Random().nextInt(100).toString(),
      displayName: name,
      userEmail: email,
      selectedAddress: _selectedAddress,
    );
    _isAuthenticated = true;
    notifyListeners();
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    _user?.addAddress(address);
    _user?.selectAddress(address);
    notifyListeners();
    debugPrint(user?.addresses.toString());
  }
}
