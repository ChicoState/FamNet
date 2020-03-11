//Adapted from "Making a To-do App with Flutter" https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190
import 'package:flutter/material.dart';
import 'todo.dart';

void main() => runApp(new FamNetApp());

class FamNetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-do List',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: new TodoList()
    );
  }
}

