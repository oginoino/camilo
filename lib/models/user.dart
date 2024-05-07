import '../common_libs.dart';

class UserData extends ChangeNotifier {
  String uid;
  String? displayName;
  String userEmail;
  List<Address>? addresses;
  Address? selectedAddress;

  UserData({
    required this.uid,
    required this.userEmail,
    this.displayName,
    this.addresses,
    this.selectedAddress,
  });

  void addAddress(Address address) {
    addresses ??= [];
    addresses!.map((a) => a.id).contains(address.id)
        ? null
        : addresses!.add(address);
    notifyListeners();
  }

  void removeAddress(Address address) {
    addresses ??= [];
    addresses!.map((a) => a.id).contains(address.id)
        ? addresses?.remove(address)
        : null;
    notifyListeners();
  }

  void selectAddress(Address address) {
    addresses ??= [];
    addresses!.map((a) => a.id).contains(address.id)
        ? selectedAddress = address
        : null;
    notifyListeners();
  }
}
