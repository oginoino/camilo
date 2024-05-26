import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../common_libs.dart';

class UserDataService with ChangeNotifier {
  UserData? _userData;
  UserData? get userData => _userData;
  bool isLoading = false;

  Future<UserData?> fetchUserData() async {
    isLoading = true;
    final String baseUrl = dotenv.env['API_URL']!;
    final String uid = session.user!.uid;

    const String path = '/users';

    final Uri uri = Uri.parse('$baseUrl$path/$uid');

    String? token = await session.user?.getIdToken();

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
    );

    try {
      final extractedData = json.decode(utf8.decode(response.bodyBytes));
      _userData = UserData.fromJson(extractedData);
      isLoading = false;
      notifyListeners();
      return _userData;
    } on Exception {
      _userData = null;
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserData?> createUserData() async {
    isLoading = true;
    final String baseUrl = dotenv.env['API_URL']!;

    const String path = '/users';

    final Uri uri = Uri.parse('$baseUrl$path');

    String? token = await session.user?.getIdToken(true);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
    );

    try {
      final extractedData = json.decode(utf8.decode(response.bodyBytes));
      _userData = UserData.fromJson(extractedData['data']);
      isLoading = false;
      notifyListeners();
      return _userData;
    } on Exception {
      _userData = null;
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<UserData?> updateUserAddressData(UserData? userData) async {
    isLoading = true;
    final String baseUrl = dotenv.env['API_URL']!;
    final String uid = session.user!.uid;

    const String path = '/users';

    final Uri uri = Uri.parse('$baseUrl$path/$uid');

    String? token = await session.user?.getIdToken(true);

    if (userData != null) {
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        },
        body: json.encode({
          'addresses':
              userData.addresses?.map((address) => address.toJson()).toList(),
          'selectedAddress': userData.selectedAddress?.toJson(),
        }, toEncodable: (dynamic item) => item.toJson()),
      );

      try {
        final extractedData = json.decode(utf8.decode(response.bodyBytes));
        _userData = UserData.fromJson(extractedData['data']);
        isLoading = false;
        notifyListeners();
        return _userData;
      } on Exception {
        _userData = null;
        isLoading = false;
        notifyListeners();
        return null;
      }
    }
    return null;
  }
}
