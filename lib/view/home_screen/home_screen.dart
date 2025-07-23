import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:studio93/core/utils/background_gradient.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/view/common_widgets/app_bar_widget.dart';
import 'package:studio93/view/home_screen/bloc/home_bloc.dart';
import 'package:studio93/view/home_screen/widgets/task_list_widget.dart';

import 'add_new_task_view.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'widgets/listening_animation.dart';
import 'widgets/mic_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late final GifController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = GifController(vsync: this);
    context.read<HomeBloc>().add(GetDataHomeEvent());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.transparentColor,
        drawerEnableOpenDragGesture: true,
        appBar: AppBarWidget(title: "Tasks"),
        floatingActionButton: MicRecorderWidget(controller: _controller),
        body: SafeArea(
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state.voiceStatus == VoiceStatus.completed) {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (context) => AddNewTaskView(
                          taskModelEntity: state.taskModelEntity,
                        ),
                      ),
                    )
                    .then((value) {
                      if (context.mounted) {
                        context.read<HomeBloc>().add(ResetStateHomeEvent());
                      }
                    });
              }
            },
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.internetStatus == InternetStatus.noInternet) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: Text(
                      "No Internet Connection",
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(color: AppColors.blackColorText),
                    ),
                  ),
                );
              }
              bool isListening =
                  state.voiceStatus == VoiceStatus.listening ||
                  state.voiceStatus == VoiceStatus.connecting;
              return Stack(
                children: [
                  ListeningAnimation(
                    result: state.requestingString,
                    isListening: isListening,
                    status: state.voiceStatus == VoiceStatus.connecting
                        ? "connecting"
                        : "listening",
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isListening ? 0.1 : 1.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TaskListWidget(
                        taskModelEntity: state.taskModelEntityList,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
