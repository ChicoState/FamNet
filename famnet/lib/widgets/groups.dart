//import 'dart:js';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:famnet/first_screen.dart';
import 'add_group.dart';
import 'dart:async';
import 'dart:core';

var r;

final dbRef = FirebaseDatabase.instance.reference().child("groups");
class Groups extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    r = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Search Groups',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

Post gPost;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SearchBarController<Post> _searchBarController = SearchBarController();

  //Calls get groups and then populates the search bar with all values retrieved from DB query
  Future<List<Post>> _getALlPosts(String text) async {
    var glist = await FirebaseGroups.getGroups("$text");
    List<Post> posts = [];
    if(glist.hasData==1) {
      var myList = glist.matchGroups;
      for (var i = 0; i < myList.length; i++) {
        var tgroup = myList[i];
        posts.add(Post(tgroup["Gname"], tgroup["Description"]));
      }
    }
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                child: Text("Create group"),
                onPressed: () {
                  navigateToAddGroups(context);
                },
              ),
              RaisedButton(
                child: Text("Cancel"),
                onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstScreen())); },
              ),
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
                  gPost = post;
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
//This class can be edited to better display contents when clicked
class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),
        title: Text(
          gPost.title,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        top: true,
        left: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 5,
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 50),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.group),
                        Text("Group Description : ", style: TextStyle(fontSize: 24,color: Colors.white70, fontWeight: FontWeight.bold)),
                        SizedBox(height:40),
                        Text(gPost.body, style: TextStyle(fontSize: 24,color: Colors.white70)),
                      ]
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detail()));
        onPressed: () {
          /*  TODO :  This needs to go to add so that we can send the information to the database
          *   TODO :  and I'm not sure how we're going to do that.
          */
//          Navigator.of(context).push(MaterialPageRoute(builder: (context) => add()));
          },
        elevation: 10.0,
        backgroundColor: Colors.blueGrey,
        icon: Icon(
          Icons.add
        ),
        label: Text("Add Group"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
class add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      /*
       * TODO : Fill out this, it will not be a Container, might need to make the groups page first.
       */
    );
  }
}
//A class that holds a list of maps of the retrieved json values. Not really sure what to do with the key
//but it may be important later?
class Gcreation {
  final String key;
  var hasData=1;
  List<Map> matchGroups= List<Map>();

//Takes the values from the datasnapshot and places them in the list
  Gcreation.fromJson(this.key, Map data) {
    if (data != null) {
      for (var value in data.values) {
        if (value != null) {
          var tmap = Map.from(value);
          matchGroups.add(Map.from(tmap));
        }
      }
    }
    else
      {
        hasData=0;
      }
  }
}
class FirebaseGroups {
  //Following code is how to implement queries as a stream rather than a single touch. Leaving in as reference.
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
  /// This function queries the db once to retrieve group info
  static Future<Gcreation> getGroups(String todoKey) async {
    Completer<Gcreation> completer = new Completer<Gcreation>();

    ////String accountKey = await Preferences.getAccountKey();
    /*Important!!! The following lines are a single query and can be placed on one line */
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




//Leaving in this code as a reference. May be important later
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
