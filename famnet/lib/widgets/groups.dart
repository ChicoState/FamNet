import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'add_group.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
final dbRef = FirebaseDatabase.instance.reference().child("groups");
class Groups extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SearchBarController<Post> _searchBarController = SearchBarController();



  //Buffer function that will get the data from the db then pass it along to _getALlPosts
 /* Future<List<Post>> getData(String text) async {
    return FirebaseGroups.getTodo("$text").then(onValue);
  }*/


  Future<List<Post>> _getALlPosts(String text) async {
    print("BEFORE");
    var stuff = await FirebaseGroups.getTodo("$text");
    print("printing stuff");
    print(stuff);
    print("After");
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];

    //FirebaseGroups.getTodo("$text").then(DataSnapshot snapshot)
    //{

    ////}
    //getData("$text");
    //dbRef.orderByChild("gname").equalTo("$text").once().then((DataSnapshot snapshot) {
      //var groups = new Gcreation.fromJson(snapshot.key, snapshot.value);
      //completer.complete(groups);
    //})
    //print();


    //FRANKENSTEIN
    /*
    FirebaseGroups.getGrouptream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    super.initState();
     */

    //var something =
    //FirebaseGroups.getTodo("$text").then(_updateTodo);



    posts.add(Post("$text", "group 1"));
    return posts;
  }
  Future navigateToAddGroups(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => addGroups()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: SearchBar<Post>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          cancellationWidget: Text("Cancel"),
          emptyWidget: Text("empty"),
          header: Row(
            children: <Widget>[
              RaisedButton(
                child: Text("Create group"),
                onPressed: () {
                  navigateToAddGroups(context);
                },
              ),/*
              RaisedButton(
                child: Text("Desort"),
                onPressed: () {
                  _searchBarController.removeSort();
                }
              RaisedButton/
                child: Text("Replay"),
                onPressed: () {
                  isReplay = !isReplay;
                  _searchBarController.replayLastSearch();
                },
              ),*/
            ],
          ),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(post.title),
                isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
class add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/*class _Group extends StatefulWidget {
  @override
}*/

/*  @override
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
*/
final databaseReference = FirebaseDatabase.instance.reference();
const jsonCodec=const JsonCodec();


class Gcreation {
  final String key;
  /*String Gname;
  String Description;
  String Owner;*/
  List<Map> matchGroups;

  //Gcreation(this.Gname,this.Description);

  Gcreation.fromJson(this.key, Map data) {
    print(data.values);
    for (var value in data.values) {
      print(value);
      if(value!=null) {
        matchGroups.add(value);
      }
    }
    print(matchGroups);
    /*
    Gname = data['Gname'];
    if (Gname == null) {
      print(Gname);
      Gname = '';
    }
    Description = data['Description'];
    if (Description == null) {
      Description = '';
    }
    Owner = data['Owner'];
    if(Owner==null) {
      Owner=' ';
    }
    */
  }
}
class Rgroups{
  Map group;
  Rgroups(Map value)
  {
    print("constructor called");
    group=value;
  }
}
//this class inteprets what the json will look like
//FRANKENSTEIN
class FirebaseGroups {
  /*
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getTodoStream(String todoKey,
      void onData(Todo todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("todos")
        .child(todoKey)
        .onValue
        .listen((Event event) {
      var todo = new Todo.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }
  */
  /// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
  static Future<Gcreation> getTodo(String todoKey) async {
    Completer<Gcreation> completer = new Completer<Gcreation>();

    ////String accountKey = await Preferences.getAccountKey();
    FirebaseDatabase.instance
        .reference()
        .child("groups")
        .orderByChild("Gname")
        .equalTo(todoKey)
        .once()
        .then((DataSnapshot snapshot) {
      var groups = new Gcreation.fromJson(snapshot.key, snapshot.value);
      completer.complete(groups);
    });

    return completer.future;
  }
}





/*
class Preferences {
  static const String ACCOUNT_KEY = "accountKey";

  static Future<bool> setAccountKey(String accountKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCOUNT_KEY, accountKey);
    return prefs.commit();
  }

  static Future<String> getAccountKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountKey = prefs.getString(ACCOUNT_KEY);

    // workaround - simulate a login setting this
    if (accountKey == null) {
      accountKey = "-KriFiUADpl-X07hnBC-";
    }

    return accountKey;
  }
}*/
