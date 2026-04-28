import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/cache_helper.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/appText.dart';
import '../auth/presentation/screens/login_screen.dart';
import '../home/presentation/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final userId = CacheHelper.getData(key: 'u_id');
      
      Widget nextScreen;
      if (userId != null) {
        nextScreen = const MainScreen();
      } else {
        nextScreen = const LoginScreen();
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.redGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit_note_rounded,
                    size: 80.sp,
                    color: AppColors.primaryRed,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    'Blogora',
                    style: AppTextStyles.titleStyle.copyWith(
                      color: Colors.white,
                      fontSize: 40.sp,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: 40.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'شارك أفكارك مع العالم',
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
