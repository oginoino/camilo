import '../common_libs.dart';

class UserData extends ChangeNotifier {
  String? id;
  String uid;
  String? displayName;
  String userEmail;
  String? photoUrl;
  String? userName;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isActivated;
  List<Address>? addresses;
  Address? selectedAddress;

  UserData({
    this.id,
    required this.uid,
    required this.userEmail,
    this.createdAt,
    this.updatedAt,
    this.isActivated,
    this.displayName,
    this.photoUrl,
    this.userName,
    this.addresses,
    this.selectedAddress,
  });

  // string representation
  @override
  String toString() {
    return 'UserData{id: $id, uid: $uid, userEmail: $userEmail, displayName: $displayName, photoUrl: $photoUrl, userName: $userName, createdAt: $createdAt, updatedAt: $updatedAt, isActivated: $isActivated, addresses: $addresses, selectedAddress: $selectedAddress}';
  }

  // from json
  UserData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        uid = json['uid'],
        userEmail = json['userEmail'],
        displayName = json['userDisplayName'],
        photoUrl = json['userPhotoUrl'],
        userName = json['userName'],
        createdAt = json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt'])
            : null,
        updatedAt = json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt'])
            : null,
        isActivated = json['isActivated'],
        addresses = json['addresses'] != null
            ? List<Address>.from(
                json['addresses'].map((address) => Address.fromJson(address)))
            : null,
        selectedAddress = json['selectedAddress'] != null &&
                json['selectedAddress']['id'].isNotEmpty
            ? Address.fromJson(json['selectedAddress'])
            : null;

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['uid'] = uid;
    data['userEmail'] = userEmail;
    data['userDisplayName'] = displayName;
    data['userPhotoUrl'] = photoUrl;
    data['userName'] = userName;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['isActivated'] = isActivated;
    data['addresses'] = addresses?.map((address) => address.toJson()).toList();
    data['selectedAddress'] = selectedAddress?.toJson();
    return data;
  }

  void addAddress(Address address) {
    addresses ??= [];
    if (!addresses!.map((a) => a.id).contains(address.id)) {
      addresses!.add(address);
      notifyListeners();
    }
  }

  void removeAddress(Address address) {
    addresses ??= [];
    if (addresses!.map((a) => a.id).contains(address.id)) {
      addresses?.remove(address);
      notifyListeners();
    }
  }

  void selectAddress(Address address) {
    addresses ??= [];
    if (addresses!.map((a) => a.id).contains(address.id)) {
      selectedAddress = address;
      notifyListeners();
    }
  }
}
