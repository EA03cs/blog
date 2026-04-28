import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/constant.dart';
import 'features/auth/data/repository/auth_repository.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
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
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
