import 'package:dio/dio.dart';
import '../../../../core/errors/failure.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';

class BlogRepository {
  final BlogService _blogService;

  BlogRepository(this._blogService);

  Future<List<BlogModel>> getBlogs() async {
    try {
      final response = await _blogService.getBlogs();
      final List data = response.data['data'];
      return data.map((e) => BlogModel.fromJson(e)).toList();
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }

  Future<void> createBlog({
    required String title,
    required String content,
    required String authorId,
  }) async {
    try {
      await _blogService.createBlog(
        title: title,
        content: content,
        authorId: authorId,
      );
    } catch (e) {
      if (e is DioException) {
        throw Failure.fromDioError(e).message;
      }
      throw 'حدث خطأ غير متوقع';
    }
  }
}
