import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../models/profile_model.dart';
import '../services/profile_service.dart';

class ProfileRepository {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  Future<ProfileModel> getProfile(int id) async {
    try {
      final response = await _profileService.getProfile(id);
      final List data = response.data['data'];
      return ProfileModel.fromJson(data[0]);
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }

  Future<void> updateProfile(int id, Map<String, dynamic> data) async {
    try {
      await _profileService.updateProfile(id, data);
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }

  Future<void> deleteAccount(int id) async {
    try {
      await _profileService.deleteAccount(id);
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }
}
