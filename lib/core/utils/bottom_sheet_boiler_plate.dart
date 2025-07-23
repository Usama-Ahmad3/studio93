import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studio93/res/app_colors.dart';
import 'package:studio93/res/app_images.dart';
import 'package:svg_flutter/svg_flutter.dart';

class BottomSheetBoilerPlate extends StatelessWidget {
  final double topPadding;
  final Widget contentWidget;
  final Widget? bottomBarWidget;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool canDismiss;
  const BottomSheetBoilerPlate({
    super.key,
    required this.topPadding,
    required this.contentWidget,
    required this.canDismiss,
    this.horizontalPadding,
    this.verticalPadding,
    this.bottomBarWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: bottomBarWidget ?? const SizedBox.shrink(),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (canDismiss)
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.of(context).pop(), // dismiss the sheet
                ),
              ),
            Positioned.fill(
              top: topPadding,
              child: ClipPath(
                clipper: CardShapeClipper(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor.withAlpha(245),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding ?? 15.w,
                      vertical: verticalPadding ?? 20.h,
                    ),
                    child: contentWidget,
                  ),
                ),
              ),
            ),
            Positioned(
              top: topPadding - 8,
              child: SvgPicture.asset(
                AppImages.arrowDownSvg,
                colorFilter: ColorFilter.mode(
                  AppColors.whiteColor.withAlpha(245),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    const cornerRadius = 24.0;
    const notchWidth = 72.0;
    const notchHeight = 16.0;

    // Calculate center for notch
    final centerX = size.width / 2;

    // Start from top-right corner
    path.moveTo(size.width - cornerRadius, 0);

    // Top right corner
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);

    // Right side
    path.lineTo(size.width, size.height - cornerRadius);

    // Remove bottom-right corner radius by using a straight line
    path.lineTo(size.width, size.height);

    // Bottom side (straight line across the bottom)
    path.lineTo(0, size.height);

    // Remove bottom-left corner radius by using a straight line
    path.lineTo(0, size.height - cornerRadius);

    // Left side
    path.lineTo(0, cornerRadius);

    // Top left corner
    path.quadraticBezierTo(0, 0, cornerRadius, 1);

    // Top edge until notch starts
    path.lineTo(centerX - (notchWidth / 1), 1);

    // Left curve of notch
    path.cubicTo(
      centerX - (notchWidth / 3),
      1,
      centerX - (notchWidth / 4),
      notchHeight,
      centerX,
      notchHeight,
    );

    // Right curve of notch
    path.cubicTo(
      centerX + (notchWidth / 4),
      notchHeight,
      centerX + (notchWidth / 3),
      1,
      centerX + (notchWidth / 1),
      1,
    );

    // Complete the path to top-right corner
    path.lineTo(size.width - cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
