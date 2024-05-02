class Predictions {
  final List<Prediction> predictions;
  final String status;

  Predictions(
    this.predictions,
    this.status,
  );

  Predictions.fromJson(Map<String, dynamic> json)
      : predictions = (json['predictions'] as List)
            .map((e) => Prediction.fromJson(e))
            .toList(),
        status = json['status'];
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
      : description = json['description'],
        matchedSubstrings = (json['matched_substrings'] as List)
            .map((e) => MatchedSubstrings.fromJson(e))
            .toList(),
        placeId = json['place_id'],
        reference = json['reference'],
        structuredFormatting =
            StructuredFormatting.fromJson(json['structured_formatting']),
        types = (json['types'] as List).map((e) => e.toString()).toList();
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
      : mainText = json['main_text'],
        mainTextMatchedSubstrings =
            (json['main_text_matched_substrings'] as List)
                .map((e) => MatchedSubstrings.fromJson(e))
                .toList(),
        secondaryText = json['secondary_text'],
        secondaryTextMatchedSubstrings =
            (json['secondary_text_matched_substrings'] as List)
                .map((e) => MatchedSubstrings.fromJson(e))
                .toList(),
        terms = (json['terms'] as List).map((e) => Terms.fromJson(e)).toList();
}

class MatchedSubstrings {
  final int length;
  final int offset;

  MatchedSubstrings(
    this.length,
    this.offset,
  );

  MatchedSubstrings.fromJson(Map<String, dynamic> json)
      : length = json['length'],
        offset = json['offset'];
}

class Terms {
  final int offset;
  final String value;

  Terms(
    this.offset,
    this.value,
  );

  Terms.fromJson(Map<String, dynamic> json)
      : offset = json['offset'],
        value = json['value'];
}
