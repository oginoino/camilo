import '../common_libs.dart';

class Address with ChangeNotifier {
  final String id;
  final String description;
  final String mainText;
  final String secondaryText;

  Address({
    required this.id,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });

  @override
  String toString() {
    return 'Address{id: $id, description: $description, mainText: $mainText, secondaryText: $secondaryText}';
  }
}
