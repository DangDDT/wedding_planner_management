// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationDataModel {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final bool isRead;

  const NotificationDataModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.isRead,
  });

  NotificationDataModel copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return NotificationDataModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}
