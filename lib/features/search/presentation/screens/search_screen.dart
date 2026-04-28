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
      appBar: AppBar(
        title: const Text('البحث عن أصدقاء'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.titleStyle.copyWith(fontSize: 20.sp),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'ابحث بالاسم...',
                controller: TextEditingController(),
                onChanged: (value) {
                  context.read<SearchCubit>().searchUsers(value);
                },
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
                    } else if (state is SearchSuccess) {
                      if (state.users.isEmpty) {
                        return const Center(child: Text('لا يوجد نتائج'));
                      }
                      return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(userId: user.id),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: AppColors.softRed,
                              child: Text(
                                user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : '?',
                                style: const TextStyle(color: AppColors.primaryRed),
                              ),
                            ),
                            title: Text('${user.firstName} ${user.lastName}', style: AppTextStyles.bodyStyle),
                            subtitle: Text(user.email, style: AppTextStyles.hintStyle),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          );
                        },
                      );
                    } else if (state is SearchFailure) {
                      return Center(child: Text(state.message));
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 80.sp, color: AppColors.lightGrey),
                          Text('ابدأ البحث الآن', style: AppTextStyles.hintStyle),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
