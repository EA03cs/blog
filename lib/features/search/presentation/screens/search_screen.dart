import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text(
                  'بحث',
                  style: AppTextStyles.titleStyle.copyWith(fontSize: 28.sp),
                ),
                Text(
                  'ابحث عن أصدقائك ومبدعين آخرين',
                  style: AppTextStyles.hintStyle.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  hintText: 'ابحث بالاسم أو البريد...',
                  controller: TextEditingController(),
                  onChanged: (value) {
                    context.read<SearchCubit>().searchUsers(value);
                  },
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
                      } else if (state is SearchSuccess) {
                        if (state.users.isEmpty) {
                          return _buildEmptyState('لا توجد نتائج بحث مطابقة');
                        }
                        return ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: AppColors.offWhite,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: ListTile(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileScreen(userId: user.id)),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.softRed,
                                  child: Text(
                                    user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : '?',
                                    style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text('${user.firstName} ${user.lastName}', style: AppTextStyles.bodyStyle),
                                subtitle: Text(user.email, style: AppTextStyles.hintStyle.copyWith(fontSize: 12.sp)),
                                trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: AppColors.lightGreyText),
                              ),
                            );
                          },
                        );
                      }
                      return _buildInitialState();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 80.sp, color: AppColors.lightGrey),
          SizedBox(height: 16.h),
          Text('ابدأ بالبحث عن مستخدمين', style: AppTextStyles.hintStyle),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search_rounded, size: 60.sp, color: AppColors.lightGrey),
          SizedBox(height: 16.h),
          Text(msg, style: AppTextStyles.hintStyle),
        ],
      ),
    );
  }
}
