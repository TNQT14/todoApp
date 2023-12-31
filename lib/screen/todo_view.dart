import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/todo_provider.dart';
import '../widget/todo_card.dart';
import '../widget/todo_form_screen.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Todos",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 28,
            fontFamily: 'Cera',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: context.read<TodoProvider>(),
                child: const TodoFormScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Consumer<TodoProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: provider.todos.isEmpty ? const Center(
                  child: Text('No todos added yet.'),
                ) : RefreshIndicator(
                  onRefresh: () async {
                    context.read<TodoProvider>().init();
                  },
                  child: ListView.builder(
                      itemCount: provider.todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        final todo = provider.todos[index];
                        return TodoCardScreen(
                            todo: todo,
                            onTap: (todo) {
                              todo.complete = !todo.complete;
                              context
                                  .read<TodoProvider>()
                                  .update(todo);
                            },
                            onDelete: (todo) {
                              context
                                  .read<TodoProvider>()
                                  .removeTodo(todo);
                            },
                            onEdit: (todo) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (_) {
                                        return ChangeNotifierProvider<
                                            TodoProvider>.value(
                                          value: context
                                              .read<TodoProvider>(),
                                          child: TodoFormScreen(
                                            todo: todo,
                                          ),
                                        );
                                      }));
                            });
                      }),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}


