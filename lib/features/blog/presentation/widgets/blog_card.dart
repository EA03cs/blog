import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../data/models/blog_model.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback? onReadMore;

  const BlogCard({
    super.key,
    required this.blog,
    this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.softRed,
                  child: Text(
                    blog.authorName.isNotEmpty ? blog.authorName[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: AppColors.primaryRed,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    blog.authorName,
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.primaryRed,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                Icon(Icons.more_horiz, color: AppColors.lightGreyText, size: 20.sp),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              blog.title,
              style: AppTextStyles.subtitleStyle.copyWith(
                fontSize: 18.sp,
                height: 1.3,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              blog.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyStyle.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.darkGreyText,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 14.sp, color: AppColors.lightGreyText),
                SizedBox(width: 4.w),
                Text(
                  'منذ قليل',
                  style: AppTextStyles.hintStyle.copyWith(fontSize: 11.sp),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onReadMore,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'اقرأ المزيد',
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.primaryRed,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
