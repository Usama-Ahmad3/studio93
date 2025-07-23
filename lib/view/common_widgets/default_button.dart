import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/res/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  final Color backgroundColor;
  final Color buttonTextColor;
  final int circularRadius;
  const DefaultButton({
    super.key,
    required this.onTap,
    required this.title,
    this.circularRadius = 55,
    this.isLoading = false,
    this.buttonTextColor = AppColors.blackColor,
    this.backgroundColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(circularRadius.r),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: buttonTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
        ),
      ),
    );
  }
}
