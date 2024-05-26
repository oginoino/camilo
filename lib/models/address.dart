class Address {
  String? id;
  String? description;
  String? mainText;
  String? secondaryText;

  Address({
    this.id,
    this.description,
    this.mainText,
    this.secondaryText,
  });

  @override
  String toString() {
    return 'Address{id: $id, description: $description, mainText: $mainText, secondaryText: $secondaryText}';
  }

  Address.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        description = json['description'] ?? '',
        mainText = json['mainText'] ?? '',
        secondaryText = json['secondaryText'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['description'] = description;
    data['mainText'] = mainText;
    data['secondaryText'] = secondaryText;
    return data;
  }
}
