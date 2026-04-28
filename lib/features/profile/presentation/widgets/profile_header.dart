import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../widgets/profile_circle_button.dart';

class ProfileHeader extends StatelessWidget {
  final String fullName;
  final String email;
  final bool isMyProfile;
  final bool showBackButton;
  final VoidCallback onLogout;
  final VoidCallback onBack;

  const ProfileHeader({
    super.key,
    required this.fullName,
    required this.email,
    required this.isMyProfile,
    required this.showBackButton,
    required this.onLogout,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton)
              ProfileCircleButton(
                icon: Icons.arrow_back_ios_new,
                onTap: onBack,
              )
            else
              const SizedBox(width: 40),
            Text(
              isMyProfile ? 'حسابي' : 'الملف الشخصي',
              style: AppTextStyles.subtitleStyle,
            ),
            if (isMyProfile)
              ProfileCircleButton(
                icon: Icons.logout_rounded,
                onTap: onLogout,
                iconColor: AppColors.primaryRed,
              )
            else
              const SizedBox(width: 40),
          ],
        ),
        SizedBox(height: 40.h),
        Text(
          fullName,
          style: AppTextStyles.titleStyle.copyWith(fontSize: 32.sp, height: 1.1),
        ),
        Text(
          email,
          style: AppTextStyles.hintStyle.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }
}
