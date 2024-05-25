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

  // from json
  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'],
        mainText = json['mainText'],
        secondaryText = json['secondaryText'];

  // to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['description'] = description;
    data['mainText'] = mainText;
    data['secondaryText'] = secondaryText;
    return data;
  }
}
