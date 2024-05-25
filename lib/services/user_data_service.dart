import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../common_libs.dart';
import 'package:http/http.dart' as http;

class UserDataService with ChangeNotifier {
  UserData? _userData;
  UserData? get userData => _userData;
  bool isLoading = false;

  static final UserDataService _singleton = UserDataService._internal();

  factory UserDataService() {
    return _singleton;
  }

  UserDataService._internal();

  Future<UserData?> fetchUserData() async {
    isLoading = true;
    final String baseUrl = dotenv.env['API_URL']!;
    final String uid = FirebaseAuth.instance.currentUser!.uid;

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
      final extractedData = json.decode(response.body);
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
      final extractedData = json.decode(response.body);
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
}
