import 'package:dio/dio.dart';
import '../../../../core/utils/constant.dart';

class ProfileService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
  ));

  Future<Response> getProfile(int id) async {
    return await _dio.get('user/$id/profile');
  }

  Future<Response> updateProfile(int id, Map<String, dynamic> data) async {
    return await _dio.patch('user/$id', data: data);
  }

  Future<Response> deleteAccount(int id) async {
    return await _dio.delete('user/$id');
  }
}
