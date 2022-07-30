// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  final String title;
  final String description;
  final int id;
  TaskModel({
    required this.title,
    required this.description,
    required this.id,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    int? id,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'id': id,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      description: map['description'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TaskModel(title: $title, description: $description, id: $id)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ description.hashCode ^ id.hashCode;
}
