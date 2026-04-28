import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../cubit/profile_cubit.dart';

class ProfileDeleteDialog extends StatelessWidget {
  final int userId;

  const ProfileDeleteDialog({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        title: const Text('حذف الحساب'),
        content: const Text('هل أنت متأكد؟ سيتم مسح بياناتك نهائياً.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تراجع'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileCubit>().deleteAccount(userId);
            },
            child: const Text('تأكيد الحذف', style: TextStyle(color: AppColors.primaryRed)),
          ),
        ],
      ),
    );
  }
}
