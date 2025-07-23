import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/core/utils/background_gradient.dart';
import 'package:studio93/core/utils/flush_bar_utils.dart';
import 'package:studio93/domain/task_model.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/view/common_widgets/app_bar_widget.dart';
import 'package:studio93/view/common_widgets/app_text_field.dart';
import 'package:studio93/view/common_widgets/default_button.dart';
import 'package:studio93/view/home_screen/bloc/home_bloc.dart';
import 'package:studio93/view/home_screen/bloc/home_event.dart';

class AddNewTaskView extends StatefulWidget {
  final TaskModelEntity taskModelEntity;
  final String? isHaveId;
  const AddNewTaskView({
    super.key,
    required this.taskModelEntity,
    this.isHaveId,
  });

  @override
  State<AddNewTaskView> createState() => _AddNewTaskViewState();
}

class _AddNewTaskViewState extends State<AddNewTaskView> {
  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final FocusNode _focusNote = FocusNode();
  String submitString = "Add Task";
  @override
  void initState() {
    taskNameController.text = widget.taskModelEntity.title;
    descriptionController.text = widget.taskModelEntity.description;
    if (widget.isHaveId != null) {
      submitString = "Update Task";
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    taskNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient(
      child: Scaffold(
        appBar: AppBarWidget(title: 'Add New Task', isBackArrow: true),
        backgroundColor: AppColors.transparentColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Title",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppTextField(
                    hint: "Title",
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_focusNote);
                      return null;
                    },
                    controller: taskNameController,
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppTextField(
                    hint: "description",
                    focusNode: _focusNote,
                    maxLines: 4,
                    controller: descriptionController,
                  ),
                  SizedBox(height: 150.h),
                  DefaultButton(onTap: _onTap, title: submitString),
                  SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTap() {
    if (taskNameController.text.trim().isEmpty) {
      FlushBarUtils.flushBar("Title Field Can't be Empty", context);
      return;
    }
    if (widget.isHaveId != null) {
      context.read<HomeBloc>().add(
        UpdateTaskHomeEvent(
          model: widget.taskModelEntity.copyWith(
            description: descriptionController.text,
            title: taskNameController.text,
          ),
          id: widget.isHaveId ?? '',
        ),
      );
      Navigator.pop(context);
    } else {
      context.read<HomeBloc>().add(
        AddTaskHomeEvent(
          model: widget.taskModelEntity.copyWith(
            description: descriptionController.text,
            title: taskNameController.text,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }
}
