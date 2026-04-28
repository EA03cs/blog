import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void getUserData() {
    final userJson = CacheHelper.getData(key: 'user');
    if (userJson != null) {
      final user = UserModel.decode(userJson);
      emit(AuthSuccess(user));
    }
  }

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

      await CacheHelper.saveData(key: 'user', value: user.encode());
      await CacheHelper.saveData(key: 'u_id', value: user.uId);
      
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

  Future<void> logout() async {
    await CacheHelper.removeData(key: 'user');
    await CacheHelper.removeData(key: 'u_id');
    emit(AuthInitial());
  }
}
