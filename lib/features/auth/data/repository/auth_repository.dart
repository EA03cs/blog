import 'package:dio/dio.dart';
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data['data'];
        print(data);
        return UserModel.fromJson(data[0]);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } catch (e) {
      rethrow;
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
      final response = await authService.signUp(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.data['message'] ?? 'Signup failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
