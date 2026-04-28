import 'package:dio/dio.dart';
import '../../../../core/utils/constant.dart';

class SearchService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
  ));

  Future<Response> searchUsers(String query) async {
    return await _dio.get('user/search', queryParameters: {'searchKey': query});
  }
}
