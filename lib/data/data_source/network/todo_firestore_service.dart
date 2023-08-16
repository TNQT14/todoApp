import 'package:hive/hive.dart';
import 'package:todo_app/data/todo_data_service.dart';
import 'package:todo_app/model/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoFirestoreService implements TodoDataService{

  CollectionReference todos = FirebaseFirestore.instance.collection('todos');

  @override
  Future<void> addTodo(Todo todo) async {
    todos.doc(todo.id).set(todo.toJson()).then((value) => print("Todo Added")).catchError((error) => print("Failed to add todo: $error"));
  }

  @override
  Future<void> deleteAllTodos() {
    // TODO: implement deleteAllTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    return todos.doc(todo.id).delete().then((value) => print("todo Deleted")).catchError((error) => print("Failed to delete todo: $error"));
  }

  @override
  Future<List<Todo>> getTodos() async {
    List<Todo> todoList = [];
    await todos.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        todoList.add(Todo.fromJson(doc.data() as Map<String, dynamic>));
        print(todoList);
      });
    });

    return Future.value(todoList);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    return todos
        .doc(todo.id)
        .update(todo.toJson())
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}