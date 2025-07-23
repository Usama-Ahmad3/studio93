import 'package:flutter/material.dart';
import 'package:studio93/res/app_colors.dart';

late ThemeData theme;

void themeInit(BuildContext context) {
  theme = Theme.of(context);
}

ThemeData lightTheme(BuildContext context, Color primaryColor) {
  themeInit(context);

  ///UI Theme
  return ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      tertiary: primaryColor,
      secondary: primaryColor,
      onSurface: primaryColor,
      onPrimaryContainer: AppColors.lightGreyBackgroundColor,
    ),
    primaryColor: primaryColor,
    secondaryHeaderColor: primaryColor,
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.lightTealColor),
    ),
    cardColor: AppColors.pointsGreenColor,
    iconTheme: IconThemeData(color: primaryColor),
    primaryColorLight: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.blackColorText,
        fontSize: 32,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.blackColorText,
        fontSize: 26,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.blackColorText,
        fontSize: 24,
      ),
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        color: AppColors.blackColorText,
        fontSize: 20,
      ),
      displayMedium: TextStyle(
        color: AppColors.blackColorText,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      displaySmall: TextStyle(
        color: AppColors.blackColorText,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        color: AppColors.blackColorText,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        color: AppColors.blackColorText,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: AppColors.blackColorText,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    // ignore: deprecated_member_use
    // brightness: Brightness.light,
    iconTheme: IconThemeData(color: AppColors.whiteColor),
    // ignore: deprecated_member_use
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppColors.whiteColor,
    ),
  );
}
