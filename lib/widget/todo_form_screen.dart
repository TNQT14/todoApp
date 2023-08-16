import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../provider/todo_provider.dart';

class TodoFormScreen extends StatefulWidget {
  const TodoFormScreen({super.key, this.todo});

  final Todo? todo;

  @override
  State<TodoFormScreen> createState() => _TodoFormScreenState();
}

class _TodoFormScreenState extends State<TodoFormScreen> {

  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;

  @override
  void initState() {
    _title = widget.todo?.title;
    _description = widget.todo?.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Create Todo' : 'Update Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: _title,
                    validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Title is required' : null,
                    onChanged: (val) => _title = val,
                    decoration: const InputDecoration(labelText: 'Todo'),
                  ),
                  TextFormField(
                    initialValue: _description,
                    validator: (value) => (value?.isEmpty ?? true)
                        ? 'Description is required'
                        : null,
                    // maxLines: 4,
                    onChanged: (val) => _description = val,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async => _save(context),
                      child: Text(widget.todo == null ? 'Save' : 'Update'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _save(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.validate();
      final todo = Todo(
        title: _title ?? '',
        description: _description ?? '',
        id: widget.todo?.id ?? DateTime.now().toIso8601String(),
        complete: widget.todo?.complete ?? false,
      );

      widget.todo == null
          ? context.read<TodoProvider>().addTodo(todo)
          : context.read<TodoProvider>().update(todo);

      Navigator.pop(context);
    }
  }
}