import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studio93/domain/task_model.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/core/services/date_time_format_service.dart';
import 'package:studio93/core/utils/bottom_sheet_boiler_plate.dart';
import 'package:studio93/core/utils/delete_dailog.dart';
import 'package:studio93/view/home_screen/widgets/empty_task_widget.dart';
import 'package:studio93/view/home_screen/add_new_task_view.dart';
import 'package:studio93/view/home_screen/widgets/task_detail_sheet.dart';

class TaskListWidget extends StatefulWidget {
  final List<TaskModelEntity> taskModelEntity;
  const TaskListWidget({super.key, required this.taskModelEntity});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.taskModelEntity.isNotEmpty
        ? ListView.builder(
            itemCount: widget.taskModelEntity.length,
            itemBuilder: (context, index) {
              final item = widget.taskModelEntity[index];
              return Slidable(
                closeOnScroll: true,
                useTextDirection: true,
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () {},
                    closeOnCancel: true,
                    confirmDismiss: () async => false,
                  ),
                  dragDismissible: false,
                  children: _slideTileOptionAndAction(item),
                ),
                child: InkWell(
                  onTap: () => _showTaskDetail(item),
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            child: Text(
                              item.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    decorationColor: AppColors.blackColor,
                                    decoration: TextDecoration.none,
                                  ),
                            ),
                          ),
                          item.description.trim().isNotEmpty
                              ? SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.82,
                                  child: Text(
                                    item.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.textGreyColor,
                                          decorationColor: AppColors.blackColor,
                                        ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.82,
                            child: Text(
                              maxLines: 1,
                              "Scheduled Time: ${dateFormatService(date: "${item.date} ${item.time}", context: context)}",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    decorationColor: AppColors.secondaryColor,
                                    color: AppColors.secondaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : EmptyTaskWidget();
  }

  _slideTileOptionAndAction(TaskModelEntity model) {
    return [
      ...List.generate(2, (index) {
        return Builder(
          builder: (innerContext) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  Slidable.of(innerContext)?.close();
                  if (index == 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddNewTaskView(
                          taskModelEntity: model,
                          isHaveId: model.id,
                        ),
                      ),
                    );
                  } else {
                    deleteDialog(context, model.id ?? '');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: index == 0
                        ? AppColors.secondaryColor
                        : AppColors.redColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        index == 0 &&
                                Directionality.of(context) == TextDirection.ltr
                            ? 10.r
                            : 0,
                      ),
                      topLeft: Radius.circular(
                        index == 0 &&
                                Directionality.of(context) == TextDirection.ltr
                            ? 10.r
                            : 0,
                      ),
                      topRight: Radius.circular(
                        index == 0 &&
                                Directionality.of(context) == TextDirection.rtl
                            ? 10.r
                            : 0,
                      ),
                      bottomRight: Radius.circular(
                        index == 0 &&
                                Directionality.of(context) == TextDirection.rtl
                            ? 10.r
                            : 0,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 2.h,
                      children: [
                        Icon(
                          index == 0 ? Icons.edit : Icons.delete,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        Text(
                          index == 0 ? 'edit' : "delete",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    ];
  }

  _showTaskDetail(TaskModelEntity model) {
    return showModalBottomSheet(
      context: context,
      elevation: 10,
      barrierColor: Colors.black87,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) => BottomSheetBoilerPlate(
        topPadding: getPaddingFromTop(model, context),
        canDismiss: true,
        horizontalPadding: 10.w,
        contentWidget: TaskDetailSheet(modelEntity: model),
      ),
    );
  }

  double getPaddingFromTop(TaskModelEntity model, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    int contentSections = 0;

    if (model.description.isNotEmpty) contentSections++;
    if (model.title.isNotEmpty) contentSections++;
    if (model.time != null && model.date != null) contentSections++;

    switch (contentSections) {
      case 0:
        return screenHeight * 0.65;
      case 1:
        return screenHeight * 0.6;
      case 2:
        return screenHeight * 0.52;
      case 3:
        return screenHeight * 0.42;
      case 4:
        return screenHeight * 0.37;
      case 5:
        return screenHeight * 0.3;
      default:
        return screenHeight * 0.35;
    }
  }
}
