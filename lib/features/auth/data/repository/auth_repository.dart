import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authService.login(email: email, password: password);
      
      if (response.data['data'] == null || (response.data['data'] as List).isEmpty) {
        throw 'البيانات المستلمة فارغة';
      }

      final List data = response.data['data'];
      return UserModel.fromJson(data[0]);
    } catch (e) {
      debugPrint("Login Error Detail: $e"); // بيطبع الخطأ بالتفصيل في الـ Console
      
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      
      if (e is TypeError) {
        throw 'خطأ في نوع البيانات المستلمة من السيرفر';
      }
      
      throw e.toString(); // هيرجع رسالة الخطأ الحقيقية عشان نعرف المشكلة فين
    }
  }

  Future<void> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      await authService.signUp(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      debugPrint("SignUp Error Detail: $e");
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw e.toString();
    }
  }
}
