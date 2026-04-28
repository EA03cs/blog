import 'package:dio/dio.dart';
import '../../../../core/utils/constant.dart';

class AuthService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  Future<Response> signUp({
    required String firstName,
    required String middleName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await dio.post('auth/signup', data: {
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
    });
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await dio.post('auth/login', data: {
      "email": email,
      "password": password,
    });
  }
}
