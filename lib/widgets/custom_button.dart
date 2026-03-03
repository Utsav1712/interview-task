import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

enum ButtonType { primary, secondary, outlined }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 48.h,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, size: 20.r, color: AppColors.textOnPrimary)
              : const SizedBox.shrink(),
          label: Text(label, style: AppTextStyles.labelLarge),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          ),
        );
      case ButtonType.secondary:
        return ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, size: 20.r, color: AppColors.textOnPrimary)
              : const SizedBox.shrink(),
          label: Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.textOnPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          ),
        );
      case ButtonType.outlined:
        return OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, size: 20.r, color: AppColors.primary)
              : const SizedBox.shrink(),
          label: Text(
            label,
            style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          ),
        );
    }
  }
}
