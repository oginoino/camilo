class Predictions {
  final List<Prediction> predictions;
  final String status;
  final String? errorMessage; // Novo campo para mensagens de erro

  Predictions(this.predictions, this.status, {this.errorMessage});

  Predictions.fromJson(Map<String, dynamic> json)
      : predictions = (json['predictions'] as List<dynamic>?)
                ?.map((p) => Prediction.fromJson(p as Map<String, dynamic>))
                .toList() ??
            [],
        status = json['status'] ?? 'UNKNOWN',
        errorMessage = json['error_message'] ?? '';

  bool get hasError => errorMessage != null && predictions.isEmpty;
}

class Prediction {
  final String description;

  final String placeId;

  final StructuredFormatting structuredFormatting;

  Prediction(
    this.description,
    this.placeId,
    this.structuredFormatting,
  );

  Prediction.fromJson(Map<String, dynamic> json)
      : description = json['description'] ?? '',
        placeId = json['place_id'] ?? '',
        structuredFormatting = json['structured_formatting'] != null
            ? StructuredFormatting.fromJson(
                json['structured_formatting'] as Map<String, dynamic>)
            : StructuredFormatting.empty();

  static empty() => Prediction('', '', StructuredFormatting.empty());
}

class StructuredFormatting {
  final String mainText;
  final String secondaryText;

  StructuredFormatting(
    this.mainText,
    this.secondaryText,
  );

  StructuredFormatting.fromJson(Map<String, dynamic> json)
      : mainText = json['main_text'] ?? '',
        secondaryText = json['secondary_text'] ?? '';

  static empty() => StructuredFormatting('', '');
}
