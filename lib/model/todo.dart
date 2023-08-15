import 'package:hive/hive.dart';
import 'dart:io';
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

  @override
  String toString() => '$id: $title: $description: $complete';
}