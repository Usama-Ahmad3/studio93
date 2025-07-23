import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/res/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  final String title;
  final Widget? titleWidget;
  final bool isBackArrow;
  const AppBarWidget({
    super.key,
    required this.title,
    this.titleWidget,
    this.isBackArrow = false,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparentColor,
      toolbarHeight: 60.h,
      elevation: 0,
      centerTitle: true,
      leading: isBackArrow
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blackColor),
            )
          : SizedBox.shrink(),
      title:
          titleWidget ??
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(fontSize: 24),
          ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size(double.infinity, 60.h);
}
