import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputField extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final String? hintText;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool showCursor;

  const SearchInputField({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    this.hintText,
    this.onTap,
    this.readOnly = false,
    this.showCursor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.r, color: const Color(0xFF7D7D7D)),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF7D7D7D),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: controller,
                  onTap: onTap,
                  readOnly: readOnly,
                  showCursor: showCursor,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF1D1B20),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
