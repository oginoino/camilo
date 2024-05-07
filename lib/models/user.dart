import '../common_libs.dart';

class User extends ChangeNotifier {
  String uid;
  String displayName;
  String userEmail;
  List<Address>? addresses;
  Address? selectedAddress;

  User({
    required this.uid,
    required this.displayName,
    required this.userEmail,
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
