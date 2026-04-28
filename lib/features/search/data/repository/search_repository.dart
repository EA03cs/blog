import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../models/search_user_model.dart';
import '../services/search_service.dart';

class SearchRepository {
  final SearchService _searchService;

  SearchRepository(this._searchService);

  Future<List<SearchUserModel>> searchUsers(String query) async {
    try {
      final response = await _searchService.searchUsers(query);
      final List data = response.data['data'];
      return data.map((e) => SearchUserModel.fromJson(e)).toList();
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }
}
