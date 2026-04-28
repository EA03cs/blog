import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> getProfile(int id) async {
    emit(ProfileLoading());
    try {
      final profile = await _profileRepository.getProfile(id);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(int id, Map<String, dynamic> data) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updateProfile(id, data);
      emit(ProfileUpdateSuccess());
      getProfile(id);
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteAccount(int id) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.deleteAccount(id);
      emit(ProfileDeleteSuccess());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
