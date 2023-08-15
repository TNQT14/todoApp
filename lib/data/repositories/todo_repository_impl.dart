import 'package:hive/hive.dart';
import 'package:todo_app/data/repositories/todo_repository.dart';
import 'package:todo_app/model/todo.dart';

import '../data_source/local/todo_db_service.dart';
import '../data_source/network/todo_firestore_service.dart';

class TodoRepositoryImpl implements TodoRepository{
  late TodoDbService _todoDbService;
  late TodoFirestoreService _todoFirestoreService;

  late Box box;

  TodoProvider(){
    _initHive();
  }

  _initHive() async{
    box = Hive.box<Todo>('todos');
  }

  TodoRepositoryImpl(
      {TodoDbService? todoDbService,
        TodoFirestoreService? todoFirestoreService})
      : _todoDbService = todoDbService ?? TodoDbService(),
        _todoFirestoreService = todoFirestoreService ?? TodoFirestoreService();

  @override
  Future<void> addTodo(Todo todo) async{
    await box.put(todo.id, todo);
  }

  @override
  Future<void> deleteTodo(Todo todo) async{
    await box.delete(todo.id);
  }

  @override
  Future<void> updateTodo(Todo todo) async{
  }

  @override
  Future<void> deleteAllTodos() async{
    await box.clear();
  }

  @override
  Future<List<Todo>> getAllTodos() {
      return _todoFirestoreService
          .getTodos()
          .catchError((error) => _todoDbService.getTodos())
          .then((value) => value);
  }
  
}