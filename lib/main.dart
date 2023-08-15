import 'package:flutter/material.dart';
import 'package:todo_app/screen/splash.dart';
import 'package:todo_app/screen/todo_screen.dart';
import 'package:todo_app/screen/todo_view.dart';
import 'package:todo_app/widget/todo_form_screen.dart';

import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    late Todo? todo;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

