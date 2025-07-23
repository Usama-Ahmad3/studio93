import 'package:equatable/equatable.dart';
import 'package:studio93/domain/task_model.dart';

abstract class HomeEvent extends Equatable {}

class ResetStateHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class RequestToGeminiHomeEvent extends HomeEvent {
  RequestToGeminiHomeEvent();
  @override
  List<Object?> get props => [];
}

class StartListeningHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class StopListeningHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class CheckInternetStreamHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class CheckPermissionHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SpeechToTextInitializeHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class OnResultHomeEvent extends HomeEvent {
  final String result;
  OnResultHomeEvent({required this.result});
  @override
  List<Object?> get props => [result];
}

class OnSoundLevelChangeHomeEvent extends HomeEvent {
  final double level;
  OnSoundLevelChangeHomeEvent({required this.level});
  @override
  List<Object?> get props => [level];
}

class GetDataHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class AddTaskHomeEvent extends HomeEvent {
  final TaskModelEntity model;
  AddTaskHomeEvent({required this.model});
  @override
  List<Object?> get props => [model];
}

class UpdateTaskHomeEvent extends HomeEvent {
  final TaskModelEntity model;
  final String id;
  UpdateTaskHomeEvent({required this.model, required this.id});
  @override
  List<Object?> get props => [model, id];
}

class DeleteTaskHomeEvent extends HomeEvent {
  final String id;
  DeleteTaskHomeEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
