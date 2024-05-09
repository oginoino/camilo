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
        errorMessage = json['error_message'];

  bool get hasError => errorMessage != null && predictions.isEmpty;
}

class Prediction {
  final String description;
  final List<MatchedSubstrings> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<String> types;

  Prediction(
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.types,
  );

  Prediction.fromJson(Map<String, dynamic> json)
      : description = json['description'] ?? '',
        matchedSubstrings = (json['matched_substrings'] as List<dynamic>?)
                ?.map((ms) =>
                    MatchedSubstrings.fromJson(ms as Map<String, dynamic>))
                .toList() ??
            [],
        placeId = json['place_id'] ?? '',
        reference = json['reference'] ?? '',
        structuredFormatting = json['structured_formatting'] != null
            ? StructuredFormatting.fromJson(
                json['structured_formatting'] as Map<String, dynamic>)
            : StructuredFormatting.empty(),
        types = (json['types'] as List<dynamic>?)
                ?.map((type) => type.toString())
                .toList() ??
            [];

  static empty() =>
      Prediction('', [], '', '', StructuredFormatting.empty(), []);
}

class StructuredFormatting {
  final String mainText;
  final List<MatchedSubstrings> mainTextMatchedSubstrings;
  final String secondaryText;
  final List<MatchedSubstrings> secondaryTextMatchedSubstrings;
  final List<Terms> terms;

  StructuredFormatting(
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
    this.secondaryTextMatchedSubstrings,
    this.terms,
  );

  StructuredFormatting.fromJson(Map<String, dynamic> json)
      : mainText = json['main_text'] ?? '',
        mainTextMatchedSubstrings =
            (json['main_text_matched_substrings'] as List<dynamic>?)
                    ?.map((mt) =>
                        MatchedSubstrings.fromJson(mt as Map<String, dynamic>))
                    .toList() ??
                [],
        secondaryText = json['secondary_text'] ?? '',
        secondaryTextMatchedSubstrings =
            (json['secondary_text_matched_substrings'] as List<dynamic>?)
                    ?.map((st) =>
                        MatchedSubstrings.fromJson(st as Map<String, dynamic>))
                    .toList() ??
                [],
        terms = (json['terms'] as List<dynamic>?)
                ?.map((term) => Terms.fromJson(term as Map<String, dynamic>))
                .toList() ??
            [];

  static empty() => StructuredFormatting('', [], '', [], []);
}

class MatchedSubstrings {
  final int length;
  final int offset;

  MatchedSubstrings(this.length, this.offset);

  MatchedSubstrings.fromJson(Map<String, dynamic> json)
      : length = json['length'] ?? 0,
        offset = json['offset'] ?? 0;
}

class Terms {
  final int offset;
  final String value;

  Terms(
    this.offset,
    this.value,
  );

  Terms.fromJson(Map<String, dynamic> json)
      : offset = json['offset'] ?? 0,
        value = json['value'] ?? '';
}
