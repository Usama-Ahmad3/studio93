import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:studio93/data/model/filtered_gemini_response_model.dart';
import 'package:studio93/data/model/gemini_original_response.dart';
import 'package:studio93/domain/task_model.dart';

class GeminiApiService {
  Future<Either<TaskModelEntity, TaskModelEntity>> geminiApiService(
    Map data,
    String key,
  ) async {
    try {
      GeminiOriginalResponse model = GeminiOriginalResponse();
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$key',
        ),
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        model = GeminiOriginalResponse.fromJson(data);
        String text = model.candidates![0].content!.parts![0].text
            .toString()
            .replaceAll('```json\n', '')
            .replaceAll('\n```', '');
        Map<String, dynamic> map = jsonDecode(text);
        return right(FilteredGeminiResponseModel.fromJson(map).toDomain());
      } else {
        return left(const TaskModelEntity.empty());
      }
    } catch (e) {
      return left(const TaskModelEntity.empty());
    }
  }
}
