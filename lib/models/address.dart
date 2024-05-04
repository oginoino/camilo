import '../common_libs.dart';

class Address with ChangeNotifier {
  final String id;
  final String description;
  final String mainText;
  final String secondaryText;

  Address({
    this.id = '',
    this.description = '',
    this.mainText = '',
    this.secondaryText = '',
  });

  Address copyWith({
    String? id,
    String? description,
    String? mainText,
    String? secondaryText,
  }) {
    return Address(
      id: id ?? this.id,
      description: description ?? this.description,
      mainText: mainText ?? this.mainText,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }
}
