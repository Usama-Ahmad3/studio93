import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart' as app_settings;
import 'package:studio93/res/app_colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

showPermissionDialog({
  required BuildContext context,
  required String image,
  required String title,
  required bool canDismiss,
  required String subtitle,
  VoidCallback? onTap,
}) {
  return showDialog(
    context: context,
    barrierDismissible: canDismiss,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.whiteColor,
      insetPadding: EdgeInsets.symmetric(horizontal: 17.w),
      alignment: Alignment.center,
      content: GoToSettingDialog(
        title: title,
        image: image,
        canDismiss: canDismiss,
        subtitle: subtitle,
        onTap: onTap,
      ),
    ),
  );
}

class GoToSettingDialog extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool canDismiss;
  const GoToSettingDialog({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
    required this.canDismiss,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10.h,
      children: [
        SvgPicture.asset(image, height: 70.h),
        const SizedBox.shrink(),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 35,
          child: AutoSizeText(
            title,
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            minFontSize: 12,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox.shrink(),
        Row(
          spacing: 10.w,
          children: [
            ...List.generate(
              canDismiss ? 2 : 1,
              (index) => Expanded(
                child: InkWell(
                  onTap: index == 0
                      ? () async {
                          Navigator.pop(context);
                          await app_settings.openAppSettings();
                        }
                      : () => Navigator.pop(context),
                  child: Container(
                    height: 50.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? AppColors.primaryColor
                          : AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(17.r),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        minFontSize: 10,
                        index == 0 ? "goToSetting" : "cancel",
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
