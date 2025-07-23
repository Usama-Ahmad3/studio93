import 'package:studio93/domain/gemini_response_model_entity.dart';

class FilteredGeminiResponseModel {
  final String time;
  final String date;
  final String title;
  final String description;

  FilteredGeminiResponseModel({
    this.time = '',
    this.title = '',
    this.date = '',
    this.description = '',
  });
  factory FilteredGeminiResponseModel.fromJson(Map<String, dynamic> json) {
    return FilteredGeminiResponseModel(
      time: json['time'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      description: json["description"] ?? '',
    );
  }
  GeminiResponseModelEntity toDomain() => GeminiResponseModelEntity(
    date: date.isNotEmpty
        ? date
        : DateTime.now().toIso8601String().split("T")[0],
    description: description,
    time: time.trim().isNotEmpty
        ? time
        : "${DateTime.now().hour}:${DateTime.now().minute}",
    title: title,
  );
}
