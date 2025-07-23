import 'package:equatable/equatable.dart';
import 'package:studio93/domain/task_model.dart';

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
  final TaskModelEntity taskModelEntity;
  final List<TaskModelEntity> taskModelEntityList;
  final double level;
  final bool isCanSpeechToText;
  final bool isLoading;
  const HomeState({
    this.internetStatus = InternetStatus.hasInternet,
    this.voiceStatus = VoiceStatus.initial,
    this.geminiRequestStatus = GeminiRequestStatus.initial,
    this.taskModelEntity = const TaskModelEntity.empty(),
    this.requestingString = '',
    this.level = 0.0,
    this.taskModelEntityList = const [],
    this.isCanSpeechToText = false,
    this.isLoading = true,
  });
  HomeState copyWith({
    InternetStatus? internetStatus,
    String? requestingString,
    VoiceStatus? voiceStatus,
    GeminiRequestStatus? geminiRequestStatus,
    TaskModelEntity? taskModelEntity,
    List<TaskModelEntity>? taskModelEntityList,
    double? level,
    bool? isCanSpeechToText,
    bool? isLoading,
  }) {
    return HomeState(
      internetStatus: internetStatus ?? this.internetStatus,
      requestingString: requestingString ?? this.requestingString,
      taskModelEntity: taskModelEntity ?? this.taskModelEntity,
      voiceStatus: voiceStatus ?? this.voiceStatus,
      geminiRequestStatus: geminiRequestStatus ?? this.geminiRequestStatus,
      isCanSpeechToText: isCanSpeechToText ?? this.isCanSpeechToText,
      level: level ?? this.level,
      isLoading: isLoading ?? this.isLoading,
      taskModelEntityList: taskModelEntityList ?? this.taskModelEntityList,
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
    taskModelEntity,
    taskModelEntityList,
  ];
}
