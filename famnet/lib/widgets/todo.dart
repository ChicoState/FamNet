import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:famnet/sign_in.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:famnet/first_screen.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
//GoogleSignInAccount currentUser = googleSignIn.currentUser;
//String userId = currentUser.id;
class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  String _email = email;
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Prevents empty strings from being added
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
      _saveData(new Tlist(false,task,true));
    }
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
        actions: <Widget>[
          //empty button that does nothing
          IconButton(
            onPressed: null,
            icon: Icon(Icons.adb),
          ),
        ],
      ),

      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }
}
final databaseReference = FirebaseDatabase.instance.reference();
//const jsonCodec=const JsonCodec();
//Encodes data in json then sends it onto database
void _saveData(Tlist list) async {
  //var json=jsonCodec.encode(list);
  final FirebaseUser user = await _auth.currentUser();
  var json = list.toJson();
  databaseReference.child("todo").push().set(json);
}
//this class inteprets what the json will look like
class Tlist {
  String jsonId = userId;
  bool finished;
  String task;
  bool inUse;

  Tlist(this.finished,this.task,this.inUse);

  Map toJson() {
    return {"id":jsonId,"finished":finished,"task":task,"inuse":inUse};
  }
}
