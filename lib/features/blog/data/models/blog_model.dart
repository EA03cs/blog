class BlogModel {
  final int id;
  final String title;
  final String content;
  final String authorName;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['b_id'] ?? 0,
      title: json['b_title'] ?? '',
      content: json['b_content'] ?? '',
      authorName: json['authorName'] ?? '',
    );
  }
}
