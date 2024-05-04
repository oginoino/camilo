import 'package:camilo/models/address.dart';

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
    addresses?.add(address);
    notifyListeners();
  }

  void removeAddress(Address address) {
    addresses?.remove(address);
    notifyListeners();
  }

  void selectAddress(Address address) {
    selectedAddress = address;
    notifyListeners();
  }
}
