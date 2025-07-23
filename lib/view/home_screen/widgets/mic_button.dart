import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:studio93/res/app_images.dart';
import 'package:studio93/core/utils/flush_bar_utils.dart';
import 'package:studio93/core/utils/show_permission_dialog.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class MicRecorderWidget extends StatefulWidget {
  final GifController controller;
  const MicRecorderWidget({super.key, required this.controller});

  @override
  State<MicRecorderWidget> createState() => _MicRecorderWidgetState();
}

class _MicRecorderWidgetState extends State<MicRecorderWidget>
    with WidgetsBindingObserver {
  Timer? _recordingTimer;
  bool _isRecording = false;
  @override
  void initState() {
    context.read<HomeBloc>().add(CheckPermissionHomeEvent());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (context.read<HomeBloc>().state.voiceStatus ==
        VoiceStatus.noPermission) {
      if (state == AppLifecycleState.inactive) {
        context.read<HomeBloc>().add(CheckPermissionHomeEvent());
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _startRecording() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer(const Duration(milliseconds: 200), () {
      final state = context.read<HomeBloc>().state;
      if (state.internetStatus == InternetStatus.noInternet) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        FlushBarUtils.flushBar(
          "Seems like you're not connected to internet",
          context,
        );
      } else if (state.voiceStatus == VoiceStatus.noPermission) {
        showPermissionDialog(
          context: context,
          image: AppImages.microphonePermission,
          canDismiss: true,
          title: "Speech And Microphone",
          subtitle:
              "Go to Settings to Allow AI Voice to access mic and speech recognition on your device",
        );
      } else {
        if (!_isRecording) {
          setState(() => _isRecording = true);
          context.read<HomeBloc>().add(SpeechToTextInitializeHomeEvent());
        }
      }
    });
  }

  Future<void> _stopRecording() async {
    _recordingTimer?.cancel();
    if (_isRecording) {
      setState(() => _isRecording = false);
      await Future.delayed(const Duration(milliseconds: 50));
      if (mounted) {
        context.read<HomeBloc>().add(StopListeningHomeEvent());
      }
    }
  }

  Future<void> _stopRecordingWithRequest() async {
    final bloc = context.read<HomeBloc>();
    _recordingTimer?.cancel();
    if (_isRecording) {
      setState(() => _isRecording = false);
      bloc.add(StopListeningHomeEvent());
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted && bloc.state.requestingString.trim().isNotEmpty) {
        bloc.add(RequestToGeminiHomeEvent());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _startRecording(),
      onPointerUp: (_) {
        final result = context.read<HomeBloc>().state;
        if (result.requestingString.trim().isNotEmpty) {
          _stopRecordingWithRequest();
        } else {
          _stopRecording();
        }
      },
      onPointerCancel: (_) {
        final result = context.read<HomeBloc>().state;
        if (result.requestingString.isNotEmpty) {
          _stopRecordingWithRequest();
        } else {
          _stopRecording();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final result = context.read<HomeBloc>().state;
          if (result.requestingString.isNotEmpty) {
            _stopRecordingWithRequest();
          }
        },
        child: SizedBox(
          width: 80.w,
          height: 80.h,
          child: Gif(
            image: const AssetImage(AppImages.aiIconImageAnimation),
            controller: widget.controller,
            // fps: 30,
            // duration: const Duration(seconds: 3),
            autostart: Autostart.loop,
            placeholder: (context) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
              child: Image.asset(AppImages.aiIconImage),
            ),
            onFetchCompleted: () {
              widget.controller.reset();
              widget.controller.forward();
            },
          ),
        ),
      ),
    );
  }
}
