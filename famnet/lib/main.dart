//Adapted from "Making a To-do App with Flutter" https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190
import 'package:flutter/material.dart';
import 'todo.dart';
import 'poll.dart';
import 'multi_form.dart';

void main() => runApp(FamNetApp());

class FamNetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      //home: new TodoList(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MultiForm(),
      ),
    );
  }
}