//Adapted from "Making a To-do App with Flutter" https://medium.com/the-web-tub/making-a-todo-app-with-flutter-5c63dab88190
import 'package:flutter/material.dart';
import 'widgets/todo.dart';
import 'widgets/polls/multi_form.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(FamNetApp());

class FamNetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
    
