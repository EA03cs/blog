import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
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
    emit(AuthLoading());
    try {
      await authRepository.signUp(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );
      emit(SignupSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
