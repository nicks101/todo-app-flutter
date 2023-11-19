class Todo {
  final String id;
  final String title;
  final bool completed;
  final String createdAt;
  final String updatedAt;
  final String userId;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
    required this.createdAt,
    this.updatedAt = '',
    this.userId = '',
  });

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        completed = json['completed'] ?? false,
        createdAt = json['createdAt'] ?? '',
        updatedAt = json['updatedAt'] ?? '',
        userId = json['userId'] ?? '',
        id = json['id'] ?? '';

  Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'userId': userId,
        'id': id,
      };

  Todo copyWith({
    String? id,
    String? title,
    bool? completed,
    String? createdAt,
    String? updatedAt,
    String? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'Todo{title: $title, completed: $completed, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          completed == other.completed &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          userId == other.userId &&
          id == other.id;

  @override
  int get hashCode =>
      title.hashCode ^
      completed.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      userId.hashCode ^
      id.hashCode;
}
