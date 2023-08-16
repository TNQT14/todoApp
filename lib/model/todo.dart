import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo{
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late bool complete;

  Todo({required this.id,
        required this.title,
        required this.description,
        required this.complete});

  // @override
  // String toString() => '$id: $title: $description: $complete';
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      complete: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': complete,
    };
  }
}