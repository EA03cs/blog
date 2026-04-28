import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../blog/presentation/cubit/blog_cubit.dart';
import '../../../blog/presentation/cubit/blog_state.dart';
import '../../../blog/presentation/widgets/blog_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogCubit>().getBlogs();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthCubit>().state;
    String userName = '';
    if (authState is AuthSuccess) {
      userName = authState.user.firstName;
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً، $userName',
                      style: AppTextStyles.titleStyle.copyWith(fontSize: 28.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'اكتشف آخر المقالات والأفكار',
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<BlogCubit, BlogState>(
                  builder: (context, state) {
                    if (state is BlogLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryRed),
                      );
                    } else if (state is BlogLoaded) {
                      if (state.blogs.isEmpty) {
                        return const Center(child: Text('لا توجد مقالات حالياً'));
                      }
                      return RefreshIndicator(
                        onRefresh: () => context.read<BlogCubit>().getBlogs(),
                        color: AppColors.primaryRed,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                          itemCount: state.blogs.length,
                          itemBuilder: (context, index) {
                            return BlogCard(
                              blog: state.blogs[index],
                              onReadMore: () {

                              },
                            );
                          },
                        ),
                      );
                    } else if (state is BlogError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
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
