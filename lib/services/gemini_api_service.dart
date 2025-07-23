import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:studio93/domain/gemini_response_model_entity.dart';
import 'package:studio93/model/filtered_gemini_response_model.dart';
import 'package:studio93/model/gemini_original_response.dart';

class GeminiApiService {
  Future<Either<GeminiResponseModelEntity, GeminiResponseModelEntity>>
  geminiApiService(Map data, String key) async {
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
        return left(const GeminiResponseModelEntity.empty());
      }
    } catch (e) {
      return left(const GeminiResponseModelEntity.empty());
    }
  }
}
