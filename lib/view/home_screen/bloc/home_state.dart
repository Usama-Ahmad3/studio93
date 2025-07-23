import 'package:equatable/equatable.dart';
import 'package:studio93/domain/gemini_response_model_entity.dart';

enum VoiceStatus {
  initial,
  connecting,
  listening,
  precessing,
  completed,
  stop,
  noPermission,
}

enum InternetStatus { noInternet, hasInternet }

enum GeminiRequestStatus { initial, processing }

class HomeState extends Equatable {
  final InternetStatus internetStatus;
  final VoiceStatus voiceStatus;
  final GeminiRequestStatus geminiRequestStatus;
  final String requestingString;
  final GeminiResponseModelEntity geminiResponseModelEntity;
  final List<GeminiResponseModelEntity> geminiResponseModelEntityList;
  final double level;
  final bool isCanSpeechToText;
  final bool isLoading;
  const HomeState({
    this.internetStatus = InternetStatus.hasInternet,
    this.voiceStatus = VoiceStatus.initial,
    this.geminiRequestStatus = GeminiRequestStatus.initial,
    this.geminiResponseModelEntity = const GeminiResponseModelEntity.empty(),
    this.requestingString = '',
    this.level = 0.0,
    this.geminiResponseModelEntityList = const [],
    this.isCanSpeechToText = false,
    this.isLoading = true,
  });
  HomeState copyWith({
    InternetStatus? internetStatus,
    String? requestingString,
    VoiceStatus? voiceStatus,
    GeminiRequestStatus? geminiRequestStatus,
    GeminiResponseModelEntity? geminiResponseModelEntity,
    List<GeminiResponseModelEntity>? geminiResponseModelEntityList,
    double? level,
    bool? isCanSpeechToText,
    bool? isLoading,
  }) {
    return HomeState(
      internetStatus: internetStatus ?? this.internetStatus,
      requestingString: requestingString ?? this.requestingString,
      geminiResponseModelEntity:
          geminiResponseModelEntity ?? this.geminiResponseModelEntity,
      voiceStatus: voiceStatus ?? this.voiceStatus,
      geminiRequestStatus: geminiRequestStatus ?? this.geminiRequestStatus,
      isCanSpeechToText: isCanSpeechToText ?? this.isCanSpeechToText,
      level: level ?? this.level,
      isLoading: isLoading ?? this.isLoading,
      geminiResponseModelEntityList:
          geminiResponseModelEntityList ?? this.geminiResponseModelEntityList,
    );
  }

  @override
  List<Object?> get props => [
    internetStatus,
    voiceStatus,
    geminiRequestStatus,
    isLoading,
    requestingString,
    isCanSpeechToText,
    level,
    geminiResponseModelEntity,
    geminiResponseModelEntityList,
  ];
}
