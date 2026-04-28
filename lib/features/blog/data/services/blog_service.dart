import 'package:dio/dio.dart';
import '../../../../core/utils/constant.dart';

class BlogService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
  ));

  Future<Response> getBlogs() async {
    return await _dio.get('blog/getBlogs');
  }

  Future<Response> createBlog({
    required String title,
    required String content,
    required String authorId,
  }) async {
    return await _dio.post('blog/createBlog', data: {
      "title": title,
      "content": content,
      "authorId": authorId,
    });
  }
}
