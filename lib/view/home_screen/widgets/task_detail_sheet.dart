import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/core/services/date_time_format_service.dart';
import 'package:studio93/core/utils/delete_dailog.dart';
import 'package:studio93/domain/task_model.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/view/common_widgets/default_button.dart';
import 'package:studio93/view/home_screen/add_new_task_view.dart';

class TaskDetailSheet extends StatelessWidget {
  final TaskModelEntity modelEntity;
  const TaskDetailSheet({super.key, required this.modelEntity});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(
                "Title:",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textGreyColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                modelEntity.title,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        modelEntity.description.trim().isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      "Description:",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      modelEntity.description,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.textGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        SizedBox(height: 20.h),
        modelEntity.date != null && modelEntity.time != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 110.w,
                    child: Text(
                      "DateTime:",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      dateFormatService(
                        date: "${modelEntity.date} ${modelEntity.time}",
                        context: context,
                      ),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.textGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(
                "Created At:",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textGreyColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                dateFormatService(
                  date: modelEntity.createdAt.toString(),
                  context: context,
                ),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(
                "Last Updated:",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.textGreyColor,
                ),
              ),
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                dateFormatService(
                  date: modelEntity.lastEdited.toString(),
                  context: context,
                ),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColors.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        DefaultButton(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewTaskView(
                  taskModelEntity: modelEntity,
                  isHaveId: modelEntity.id,
                ),
              ),
            );
          },
          title: "Edit Task",
        ),
        SizedBox(height: 20.h),
        DefaultButton(
          onTap: () {
            Navigator.of(context).pop();
            deleteDialog(context, modelEntity.id ?? '');
          },
          title: "Delete Task",
        ),
        const Spacer(),
      ],
    );
  }
}
