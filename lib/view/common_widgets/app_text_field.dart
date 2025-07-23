import "package:flutter/material.dart";
import "package:studio93/res/app_colors.dart";

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.maxLength = 100,
    this.validator,
    this.keyboardType,
    this.fillColor = AppColors.whiteColor,
    this.suffix,
    this.prefixIcon,
    this.hintStyle,
    this.borderColor = AppColors.transparentColor,
    this.onChanged,
    this.maxLines = 1,
    this.maxHeight = 100,
    this.focusNode,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? label;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String hint;
  final String? Function(String?)? validator;
  final Color fillColor;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextStyle? hintStyle;
  final Color borderColor;
  final void Function(String)? onChanged;
  final int maxLines;
  final double maxHeight;
  final FormFieldValidator? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final borderRadius = 15.0;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLines,
      maxLength: maxLength,
      onFieldSubmitted: onSubmitted,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.blackColor,
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: hint,
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(maxWidth: 50),
        constraints: BoxConstraints(maxHeight: maxHeight),
        errorMaxLines: 2,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 5, left: 15, top: 3),
          child: prefixIcon,
        ),
        prefixIconConstraints: const BoxConstraints(maxWidth: 40),
        hintStyle:
            hintStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color(0xFF212429),
            ),

        filled: true,
        fillColor: fillColor,
        errorStyle: TextStyle(
          fontSize: 12,
          height: 1.3,
          color: Colors.red.shade700,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
      ),
    );
  }
}
