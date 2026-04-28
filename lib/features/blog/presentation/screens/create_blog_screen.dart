import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/appText.dart';
import '../../../../core/utils/colors.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../presentation/cubit/blog_cubit.dart';
import '../../presentation/cubit/blog_state.dart';
import '../../../auth/presentation/widgets/custom_button.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({super.key});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    Text(
                      'مقال جديد',
                      style: AppTextStyles.titleStyle.copyWith(fontSize: 28.sp),
                    ),
                    Text(
                      'شارك أفكارك وتجاربك مع مجتمعك',
                      style: AppTextStyles.hintStyle.copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(height: 32.h),
                    
                    Text('عنوان المقال', style: AppTextStyles.bodyStyle),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      hintText: 'اكتب عنواناً معبّراً...',
                      controller: _titleController,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال العنوان' : null,
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    Text('المحتوى', style: AppTextStyles.bodyStyle),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _contentController,
                      maxLines: 10,
                      style: AppTextStyles.bodyStyle.copyWith(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: 'ابدأ الكتابة هنا...',
                        hintStyle: AppTextStyles.hintStyle,
                        filled: true,
                        fillColor: AppColors.offWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: AppColors.primaryRed, width: 1),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'لا يمكن نشر مقال فارغ' : null,
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    BlocConsumer<BlogCubit, BlogState>(
                      listener: (context, state) {
                        if (state is BlogCreated) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم نشر مقالك بنجاح!'), 
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          _titleController.clear();
                          _contentController.clear();
                        } else if (state is BlogError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message), 
                              backgroundColor: AppColors.error,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text: 'نشر الآن',
                          isLoading: state is BlogLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final authState = context.read<AuthCubit>().state;
                              
                              if (authState is AuthSuccess) {
                                context.read<BlogCubit>().createBlog(
                                  title: _titleController.text,
                                  content: _contentController.text,
                                  authorId: authState.user.uId.toString(),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('يجب تسجيل الدخول أولاً'),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
