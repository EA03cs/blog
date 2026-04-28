import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyles {
  static TextStyle titleStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackText,
    fontFamily: 'Cairo',
  );

  static TextStyle subtitleStyle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackText,
    fontFamily: 'Cairo',
  );

  static TextStyle bodyStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.blackText,
    fontWeight: FontWeight.bold,
    height: 1.5,
    fontFamily: 'Cairo',
  );

  static TextStyle smallTitleStyle = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackText,
    fontFamily: 'Cairo',
  );
  
  static TextStyle hintStyle = TextStyle(
    fontSize: 13.sp,
    color: AppColors.lightGreyText,
    fontFamily: 'Cairo',
  );

  static TextStyle errorStyle = TextStyle(
    fontSize: 12.sp,
    color: AppColors.primaryRed,
    fontFamily: 'Cairo',
  );
}
