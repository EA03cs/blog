import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/blog/data/repository/blog_repository.dart';
import 'features/blog/data/services/blog_service.dart';
import 'features/blog/presentation/cubit/blog_cubit.dart';
import 'features/profile/data/repository/profile_repository.dart';
import 'features/profile/data/services/profile_service.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/search/data/repository/search_repository.dart';
import 'features/search/data/services/search_service.dart';
import 'features/search/presentation/cubit/search_cubit.dart';
import 'features/splash/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthRepository(AuthService())),
        ),
        BlocProvider(
          create: (context) => BlogCubit(BlogRepository(BlogService())),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(ProfileRepository(ProfileService())),
        ),
        BlocProvider(
          create: (context) => SearchCubit(SearchRepository(SearchService())),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blogora',
            theme: ThemeData(
              fontFamily: 'Cairo',
              scaffoldBackgroundColor: Colors.white,
            ),
            // إضافة إعدادات اللغة هنا لحل مشكلة الـ DatePicker
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'EG'), // العربية
              Locale('en', 'US'), // الإنجليزية
            ],
            locale: const Locale('ar', 'EG'), // تعيين العربية كلغة افتراضية
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
