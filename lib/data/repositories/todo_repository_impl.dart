import 'package:hive/hive.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/model/todo.dart';

import '../data_source/local/todo_db_service.dart';
import '../data_source/network/todo_firestore_service.dart';

class TodoRepositoryImpl implements TodoRepository{
  late TodoDbService _todoDbService;
  late TodoFirestoreService _todoFirestoreService;


  TodoRepositoryImpl(
      {TodoDbService? todoDbService,
        TodoFirestoreService? todoFirestoreService})
      : _todoDbService = todoDbService ?? TodoDbService(),
        _todoFirestoreService = todoFirestoreService ?? TodoFirestoreService();

  @override
  Future<List<Todo>> getAllTodos() {
      return _todoFirestoreService
          .getTodos()
          .catchError((error) => _todoDbService.getTodos())
          .then((value) => value);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    _todoFirestoreService.addTodo(todo).catchError((error) {
      _todoDbService.addTodo(todo);
    }).then((value) => value);
  }

  @override
  Future<void> deleteAllTodos() async {
    _todoDbService.deleteAllTodos().catchError((e) {
      print("add local database err :: ${e}");
    });
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    _todoFirestoreService.deleteTodo(todo).catchError((e){
      _todoDbService.deleteTodo(todo);
    }).then((value) => print("todo Deleted"),);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    _todoFirestoreService.updateTodo(todo).catchError((e){
      _todoDbService.updateTodo(todo);
    }).then((value) => print("todo Updated"),);
  }
  
}