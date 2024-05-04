import '../common_libs.dart';

class User extends ChangeNotifier {
  String uid;
  String displayName;
  String userEmail;

  User({
    required this.uid,
    required this.displayName,
    required this.userEmail,
  });
}
