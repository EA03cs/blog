import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/appText.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackText),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إنشاء حساب جديد',
                      style: AppTextStyles.titleStyle.copyWith(fontSize: 28.sp),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'انضم إلينا وابدأ بمشاركة أفكارك',
                      style: AppTextStyles.hintStyle,
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      hintText: 'الاسم الأول',
                      controller: _firstNameController,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال الاسم الأول' : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'الاسم الأوسط',
                      controller: _middleNameController,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال الاسم الأوسط' : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'اسم العائلة',
                      controller: _lastNameController,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال اسم العائلة' : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'البريد الإلكتروني',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال البريد الإلكتروني' : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'كلمة المرور',
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) => value!.isEmpty ? 'الرجاء إدخال كلمة المرور' : null,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'تأكيد كلمة المرور',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value!.isEmpty) return 'الرجاء تأكيد كلمة المرور';
                        if (value != _passwordController.text) return 'كلمات المرور غير متطابقة';
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is SignupSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم إنشاء الحساب بنجاح'), backgroundColor: AppColors.success),
                          );
                          Navigator.pop(context); // Back to login
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          text: 'تسجيل',
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signUp(
                                    firstName: _firstNameController.text,
                                    middleName: _middleNameController.text,
                                    lastName: _lastNameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  );
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
