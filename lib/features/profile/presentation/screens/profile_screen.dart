import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../widgets/profile_detail_item.dart';
import '../widgets/profile_edit_bottom_sheet.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_delete_dialog.dart';

class ProfileScreen extends StatefulWidget {
  final int? userId;

  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  void _fetchProfile() {
    if (widget.userId != null) {
      context.read<ProfileCubit>().getProfile(widget.userId!);
    } else {
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthSuccess) {
        context.read<ProfileCubit>().getProfile(authState.user.uId);
      }
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ar', 'EG'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryRed,
              onPrimary: Colors.white,
              onSurface: AppColors.blackText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    bool isMyProfile = true;
    if (widget.userId != null && authState is AuthSuccess) {
      isMyProfile = widget.userId == authState.user.uId;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileDeleteSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            } else if (state is ProfileUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تحديث البيانات بنجاح'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
            } else if (state is ProfileLoaded) {
              final profile = state.profile;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        fullName: profile.fullName,
                        email: profile.email,
                        isMyProfile: isMyProfile,
                        showBackButton: widget.userId != null,
                        onBack: () => Navigator.pop(context),
                      ),
                      SizedBox(height: 40.h),
                      Text(
                        'المعلومات الأساسية',
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.primaryRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ProfileDetailItem(
                        icon: Icons.calendar_today_rounded,
                        label: 'تاريخ الميلاد',
                        value: profile.dob,
                      ),
                      ProfileDetailItem(
                        icon: Icons.fingerprint_rounded,
                        label: 'معرف الحساب',
                        value: profile.id.toString(),
                      ),
                      ProfileDetailItem(
                        icon: Icons.verified_user_outlined,
                        label: 'حالة الحساب',
                        value: 'موثق',
                      ),
                      if (isMyProfile) ...[
                        SizedBox(height: 40.h),
                        CustomButton(
                          text: 'تعديل البيانات',
                          onPressed: () => _showEditBottomSheet(context, profile),
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: TextButton(
                            onPressed: () => _showDeleteDialog(context, profile.id),
                            child: Text(
                              'حذف الحساب نهائياً',
                              style: AppTextStyles.bodyStyle.copyWith(
                                color: AppColors.greyText,
                                fontSize: 13.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }
            return const Center(child: Text('حدث خطأ في جلب البيانات'));
          },
        ),
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context, dynamic profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileEditBottomSheet(
        profile: profile,
        onSelectDate: _selectDate,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => ProfileDeleteDialog(userId: id),
    );
  }
}
