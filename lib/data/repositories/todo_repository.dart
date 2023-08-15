import '../../model/todo.dart';

abstract class TodoRepository{
  Future<List<Todo>> getAllTodos();
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteAllTodo();
}