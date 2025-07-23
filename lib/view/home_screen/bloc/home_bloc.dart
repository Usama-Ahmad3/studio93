import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:studio93/core/services/gemini_api_service.dart';
import 'package:studio93/data/repository/auth_repo.dart';
import 'package:studio93/domain/firebase_repo_interface.dart';
import 'package:studio93/res/app_constants.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FirebaseRepoInterface firebaseRepoInterface;
  final AuthRepo authRepo;
  late final String _userId;
  HomeBloc({required this.firebaseRepoInterface, required this.authRepo})
    : super(const HomeState()) {
    _init();
    on<CheckPermissionHomeEvent>(_checkPermission);
    on<CheckInternetStreamHomeEvent>(_checkInternetStream);
    on<SpeechToTextInitializeHomeEvent>(_speechToTextInitialize);
    on<StartListeningHomeEvent>(_startListening);
    on<StopListeningHomeEvent>(_stopListening);
    on<OnResultHomeEvent>(_onResultGetting);
    on<OnSoundLevelChangeHomeEvent>(_onSoundLevelChange);
    on<GetDataHomeEvent>(_onGetData);
    on<AddTaskHomeEvent>(_onAddTask);
    on<UpdateTaskHomeEvent>(_onUpdateTask);
    on<DeleteTaskHomeEvent>(_onDeleteTask);

    ///Voice Related Func

    on<RequestToGeminiHomeEvent>(_requestToGemini);
    on<ResetStateHomeEvent>(_onReset);
  }
  final SpeechToText _speechToText = SpeechToText();
  void _init() async {
    _userId = await authRepo.getUserId();
  }

  _onAddTask(AddTaskHomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await firebaseRepoInterface.addTask(
        model: event.model
            .copyWith(lastEdited: DateTime.now(), createdAt: DateTime.now())
            .toFirestore(),
        userId: _userId,
      );
      add(GetDataHomeEvent());
    } catch (e) {
      add(CheckInternetStreamHomeEvent());
    }
  }

  _onUpdateTask(UpdateTaskHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await firebaseRepoInterface.updateTask(
        model: event.model.copyWith(lastEdited: DateTime.now()).toFirestore(),
        id: event.id,
        userId: _userId,
      );
      add(GetDataHomeEvent());
    } catch (e) {
      add(CheckInternetStreamHomeEvent());
    }
  }

  _onDeleteTask(DeleteTaskHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await firebaseRepoInterface.deleteTask(id: event.id, userId: _userId);
      add(GetDataHomeEvent());
    } catch (e) {
      add(CheckInternetStreamHomeEvent());
    }
  }

  _onReset(ResetStateHomeEvent event, Emitter<HomeState> emit) {
    emit(
      state.copyWith(
        geminiRequestStatus: GeminiRequestStatus.initial,
        isLoading: false,
        requestingString: '',
        level: 0,
        voiceStatus: VoiceStatus.initial,
      ),
    );
  }

  _onGetData(GetDataHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final userId = await authRepo.getUserId();
      final data = await firebaseRepoInterface.getTasks(userId);
      emit(state.copyWith(isLoading: false, taskModelEntityList: data));
    } catch (e) {
      add(CheckInternetStreamHomeEvent());
    }
  }

  _checkPermission(
    CheckPermissionHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      add(CheckInternetStreamHomeEvent());
    });
    PermissionStatus isHavePermission = await Permission.microphone.status;
    PermissionStatus speechPermission = Platform.isAndroid
        ? PermissionStatus.granted
        : await Permission.speech.status;
    if (isHavePermission == PermissionStatus.denied ||
        isHavePermission == PermissionStatus.permanentlyDenied ||
        speechPermission == PermissionStatus.denied ||
        speechPermission == PermissionStatus.permanentlyDenied) {
      if (!Platform.isAndroid) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.microphone,
          Permission.speech,
        ].request();
        if (statuses[Permission.microphone] == PermissionStatus.denied ||
            statuses[Permission.microphone] ==
                PermissionStatus.permanentlyDenied ||
            statuses[Permission.speech] == PermissionStatus.denied ||
            statuses[Permission.speech] == PermissionStatus.permanentlyDenied) {
          emit(state.copyWith(voiceStatus: VoiceStatus.noPermission));
        } else {
          emit(state.copyWith(voiceStatus: VoiceStatus.initial));
        }
      } else {
        isHavePermission = await Permission.microphone.request();
        if (isHavePermission == PermissionStatus.denied ||
            isHavePermission == PermissionStatus.permanentlyDenied) {
          emit(state.copyWith(voiceStatus: VoiceStatus.noPermission));
        } else {
          emit(state.copyWith(voiceStatus: VoiceStatus.initial));
        }
      }
    } else {
      emit(state.copyWith(voiceStatus: VoiceStatus.initial));
    }
  }

  _checkInternetStream(
    CheckInternetStreamHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final internet = await http.get(Uri.parse('https://www.google.com'));
      if (internet.statusCode == 200 &&
          state.internetStatus == InternetStatus.noInternet) {
        emit(state.copyWith(internetStatus: InternetStatus.hasInternet));
      }
    } catch (e) {
      emit(
        state.copyWith(
          isCanSpeechToText: false,
          internetStatus: InternetStatus.noInternet,
        ),
      );
    }
  }

  _speechToTextInitialize(
    SpeechToTextInitializeHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(voiceStatus: VoiceStatus.connecting));
      bool isAvailable = await _speechToText.initialize(
        /// onStatus: (status) => _onSpeechStatusChanged(status, emit),
        onError: (errorNotification) {
          if (kDebugMode) {
            print("Speech error: ${errorNotification.errorMsg}");
          }

          // if (errorNotification.permanent) {
          //   add(StopListeningVoiceChatEvent());
          // }
        },
      );
      emit(state.copyWith(isCanSpeechToText: isAvailable));
      add(StartListeningHomeEvent());
    } catch (e) {
      emit(
        state.copyWith(
          isCanSpeechToText: false,
          internetStatus: InternetStatus.noInternet,
        ),
      );
      if (kDebugMode) {
        print("Error ==>");
      }
    }
  }

  _startListening(
    StartListeningHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.isCanSpeechToText && !_speechToText.isListening) {
      await _speechToText.listen(
        onResult: (result) =>
            add(OnResultHomeEvent(result: result.recognizedWords)),
        listenOptions: SpeechListenOptions(listenMode: ListenMode.confirmation),
        onSoundLevelChange: (val) =>
            add(OnSoundLevelChangeHomeEvent(level: val)),
        listenFor: Duration(seconds: Platform.isAndroid ? 180 : 15),
      );
      emit(state.copyWith(voiceStatus: VoiceStatus.listening));
    }
  }

  _stopListening(StopListeningHomeEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        voiceStatus: VoiceStatus.stop,
        requestingString: state.requestingString,
      ),
    );
    await _speechToText.stop();
    await _speechToText.cancel();
  }

  _onResultGetting(OnResultHomeEvent event, Emitter<HomeState> emit) {
    if (state.isCanSpeechToText) {
      final String result = event.result;
      if (!Platform.isAndroid && event.result.isEmpty) {
        emit(state.copyWith(requestingString: state.requestingString));
      } else {
        emit(state.copyWith(requestingString: result));
      }
    }
  }

  _onSoundLevelChange(
    OnSoundLevelChangeHomeEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(level: event.level));
  }

  _requestToGemini(
    RequestToGeminiHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final today = DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
      final todayIso = DateFormat('yyyy-MM-dd').format(DateTime.now());

      Map data = {
        "contents": [
          {
            "role": "user",
            "parts": [
              {
                "text":
                    """
                Extract event information from: "${state.requestingString}"

                Instructions:
                1. Parse the text for a date, title, time (convert to 24-hour format)
                2. If no date is found, use today ($today)
                3. Write a concise description summarizing the event
                4. Add relevant emojis to the title and description

                Return ONLY a valid JSON object with these fields:
                {
                  "date": "YYYY-MM-DD format",
                  "time": "HH:MM in 24-hour format",
                  "title": "event title with emoji",
                  "description": "event description with emoji"
                }

                If the input is unclear, return as same bellow Error and don't change title:
                {
                  "date": "$todayIso",
                  "time": "",
                  "title": "Error",
                  "description": "Sorry, I didn't catch that. Could you rephrase?"
                }

                Respond in the same language as the input.
                """,
              },
            ],
          },
        ],
      };

      await GeminiApiService()
          .geminiApiService(data, AppConstants.geminiKey)
          .then((value) {
            value.fold(
              (l) {
                return emit(
                  state.copyWith(
                    taskModelEntity: l,
                    requestingString: '',
                    voiceStatus: VoiceStatus.completed,
                  ),
                );
              },
              (r) {
                return emit(
                  state.copyWith(
                    taskModelEntity: r,
                    requestingString: '',
                    voiceStatus: VoiceStatus.completed,
                  ),
                );
              },
            );
          });
    } catch (e) {
      if (kDebugMode) {
        print('Error ===> $e');
      }
    }
  }
}
