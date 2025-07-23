import 'dart:convert';

GeminiOriginalResponse geminiOriginalResponseFromJson(String str) =>
    GeminiOriginalResponse.fromJson(json.decode(str));
String geminiOriginalResponseToJson(GeminiOriginalResponse data) =>
    json.encode(data.toJson());

class GeminiOriginalResponse {
  GeminiOriginalResponse({
    List<Candidates>? candidates,
  }) {
    _candidates = candidates;
  }

  GeminiOriginalResponse.fromJson(dynamic json) {
    if (json['candidates'] != null) {
      _candidates = [];
      json['candidates'].forEach((v) {
        _candidates?.add(Candidates.fromJson(v));
      });
    }
  }
  List<Candidates>? _candidates;
  GeminiOriginalResponse copyWith({
    List<Candidates>? candidates,
  }) =>
      GeminiOriginalResponse(
        candidates: candidates ?? _candidates,
      );
  List<Candidates>? get candidates => _candidates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_candidates != null) {
      map['candidates'] = _candidates?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Candidates candidatesFromJson(String str) =>
    Candidates.fromJson(json.decode(str));
String candidatesToJson(Candidates data) => json.encode(data.toJson());

class Candidates {
  Candidates({
    Content? content,
    String? finishReason,
    int? index,
    List<SafetyRatings>? safetyRatings,
  }) {
    _content = content;
    _finishReason = finishReason;
    _index = index;
    _safetyRatings = safetyRatings;
  }

  Candidates.fromJson(dynamic json) {
    _content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    _finishReason = json['finishReason'];
    _index = json['index'];
    if (json['safetyRatings'] != null) {
      _safetyRatings = [];
      json['safetyRatings'].forEach((v) {
        _safetyRatings?.add(SafetyRatings.fromJson(v));
      });
    }
  }
  Content? _content;
  String? _finishReason;
  int? _index;
  List<SafetyRatings>? _safetyRatings;
  Candidates copyWith({
    Content? content,
    String? finishReason,
    int? index,
    List<SafetyRatings>? safetyRatings,
  }) =>
      Candidates(
        content: content ?? _content,
        finishReason: finishReason ?? _finishReason,
        index: index ?? _index,
        safetyRatings: safetyRatings ?? _safetyRatings,
      );
  Content? get content => _content;
  String? get finishReason => _finishReason;
  int? get index => _index;
  List<SafetyRatings>? get safetyRatings => _safetyRatings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_content != null) {
      map['content'] = _content?.toJson();
    }
    map['finishReason'] = _finishReason;
    map['index'] = _index;
    if (_safetyRatings != null) {
      map['safetyRatings'] = _safetyRatings?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

SafetyRatings safetyRatingsFromJson(String str) =>
    SafetyRatings.fromJson(json.decode(str));
String safetyRatingsToJson(SafetyRatings data) => json.encode(data.toJson());

class SafetyRatings {
  SafetyRatings({
    String? category,
    String? probability,
  }) {
    _category = category;
    _probability = probability;
  }

  SafetyRatings.fromJson(dynamic json) {
    _category = json['category'];
    _probability = json['probability'];
  }
  String? _category;
  String? _probability;
  SafetyRatings copyWith({
    String? category,
    String? probability,
  }) =>
      SafetyRatings(
        category: category ?? _category,
        probability: probability ?? _probability,
      );
  String? get category => _category;
  String? get probability => _probability;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['probability'] = _probability;
    return map;
  }
}

Content contentFromJson(String str) => Content.fromJson(json.decode(str));
String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    List<Parts>? parts,
    String? role,
  }) {
    _parts = parts;
    _role = role;
  }

  Content.fromJson(dynamic json) {
    if (json['parts'] != null) {
      _parts = [];
      json['parts'].forEach((v) {
        _parts?.add(Parts.fromJson(v));
      });
    }
    _role = json['role'];
  }
  List<Parts>? _parts;
  String? _role;
  Content copyWith({
    List<Parts>? parts,
    String? role,
  }) =>
      Content(
        parts: parts ?? _parts,
        role: role ?? _role,
      );
  List<Parts>? get parts => _parts;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_parts != null) {
      map['parts'] = _parts?.map((v) => v.toJson()).toList();
    }
    map['role'] = _role;
    return map;
  }
}

Parts partsFromJson(String str) => Parts.fromJson(json.decode(str));
String partsToJson(Parts data) => json.encode(data.toJson());

class Parts {
  Parts({
    String? text,
  }) {
    _text = text;
  }

  Parts.fromJson(dynamic json) {
    _text = json['text'];
  }
  String? _text;
  Parts copyWith({
    String? text,
  }) =>
      Parts(
        text: text ?? _text,
      );
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    return map;
  }
}
