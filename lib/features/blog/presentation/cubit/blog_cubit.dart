import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/blog_repository.dart';
import 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogRepository _blogRepository;

  BlogCubit(this._blogRepository) : super(BlogInitial());

  Future<void> getBlogs({bool showLoading = true}) async {
    if (showLoading) emit(BlogLoading());
    try {
      final blogs = await _blogRepository.getBlogs();
      emit(BlogLoaded(blogs));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }

  Future<void> createBlog({
    required String title,
    required String content,
    required String authorId,
  }) async {
    emit(BlogActionLoading());
    try {
      await _blogRepository.createBlog(
        title: title,
        content: content,
        authorId: authorId,
      );
      emit(BlogCreated());
      await getBlogs(showLoading: false);
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }
}
