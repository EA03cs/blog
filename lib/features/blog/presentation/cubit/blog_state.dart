import 'package:equatable/equatable.dart';
import '../../data/models/blog_model.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

// حالة تحميل خاصة بالعمليات (مثل النشر) لعدم تصفير القائمة في الواجهة
class BlogActionLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;
  const BlogLoaded(this.blogs);

  @override
  List<Object?> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;
  const BlogError(this.message);

  @override
  List<Object?> get props => [message];
}

class BlogCreated extends BlogState {}
