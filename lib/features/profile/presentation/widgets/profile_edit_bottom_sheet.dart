import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../cubit/profile_cubit.dart';
import 'profile_edit_input.dart';

class ProfileEditBottomSheet extends StatefulWidget {
  final dynamic profile;
  final Future<void> Function(BuildContext, TextEditingController) onSelectDate;

  const ProfileEditBottomSheet({
    super.key,
    required this.profile,
    required this.onSelectDate,
  });

  @override
  State<ProfileEditBottomSheet> createState() => _ProfileEditBottomSheetState();
}

class _ProfileEditBottomSheetState extends State<ProfileEditBottomSheet> {
  final fName = TextEditingController();
  final mName = TextEditingController();
  final lName = TextEditingController();
  final dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text('تعديل البيانات', style: AppTextStyles.subtitleStyle.copyWith(fontSize: 22.sp)),
              SizedBox(height: 24.h),
              ProfileEditInput(label: 'الاسم الأول', controller: fName, icon: Icons.person_outline_rounded),
              SizedBox(height: 16.h),
              ProfileEditInput(label: 'الاسم الأوسط', controller: mName, icon: Icons.person_outline_rounded),
              SizedBox(height: 16.h),
              ProfileEditInput(label: 'الكنية', controller: lName, icon: Icons.people_outline_rounded),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () async {
                  await widget.onSelectDate(context, dob);
                  setState(() {});
                },
                child: AbsorbPointer(
                  child: ProfileEditInput(
                    label: 'تاريخ الميلاد',
                    controller: dob,
                    icon: Icons.calendar_today_rounded,
                    readOnly: true,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              CustomButton(
                text: 'حفظ التغييرات',
                onPressed: () {
                  final data = {
                    if (fName.text.isNotEmpty) "firstName": fName.text,
                    if (mName.text.isNotEmpty) "middleName": mName.text,
                    if (lName.text.isNotEmpty) "lastName": lName.text,
                    if (dob.text.isNotEmpty) "DOB": dob.text,
                  };
                  if (data.isNotEmpty) {
                    context.read<ProfileCubit>().updateProfile(widget.profile.id, data);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}