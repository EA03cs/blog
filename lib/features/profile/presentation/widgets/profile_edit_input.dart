import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';

class ProfileEditInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool readOnly;

  const ProfileEditInput({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: AppTextStyles.bodyStyle,
        decoration: InputDecoration(
          icon: Icon(icon, color: AppColors.primaryRed, size: 20.sp),
          labelText: label,
          labelStyle: AppTextStyles.hintStyle,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
