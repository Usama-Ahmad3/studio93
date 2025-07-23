import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studio93/res/app_colors.dart';

class FlushBarUtils {
  static Future flushBar(String message, BuildContext context) async {
    await Flushbar(
      borderRadius: BorderRadius.circular(20.r),
      animationDuration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      barBlur: 30,
      titleColor: Colors.black,
      reverseAnimationCurve: Curves.easeInQuint,
      progressIndicatorBackgroundColor: Colors.cyanAccent,
      messageColor: Colors.black,
      boxShadows: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(1, 1),
          blurStyle: BlurStyle.normal,
        ),
      ],
      margin: const EdgeInsets.all(25),
      backgroundColor: AppColors.primaryColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static Future timerFlushBar(String message, BuildContext context) async {
    await Flushbar(
      borderRadius: BorderRadius.circular(20.r),
      animationDuration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      barBlur: 30,
      titleColor: Colors.black,
      reverseAnimationCurve: Curves.easeInQuint,
      progressIndicatorBackgroundColor: Colors.cyanAccent,
      messageColor: Colors.black,
      boxShadows: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          offset: Offset(1, 1),
          blurStyle: BlurStyle.normal,
        ),
      ],
      margin: const EdgeInsets.all(25),
      backgroundColor: AppColors.primaryColor,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 4),
    ).show(context);
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
