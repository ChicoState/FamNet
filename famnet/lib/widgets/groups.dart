import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'add_group.dart';
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
  bool isReplay = false;

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];
    print(dbRef.orderByChild("gname").equalTo("$text").once());
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
//Encodes data in json then sends it onto database
void _saveData(Tlist list) async {
  var json=jsonCodec.encode(list);
  print("json=$json");
  databaseReference.child("todo").push().set(json);

  /*var url="https://famnet-84c11.firebaseio.com/todo.json";
      var httpClient = new Client();
      var response = await httpClient.post(url, body:json);
      print("response="+response.body);*/


}
class Gcreation {
  String Gname;
  String Description;
  String Owner;

  Gcreation(this.Gname,this.Description);

  Map toJson() {
    return {"Gname":Gname,"Description":Description,"Owner":Owner};
  }
}
//this class inteprets what the json will look like
class Tlist {
  bool finished;
  String task;
  bool inuse;

  Tlist(this.finished,this.task,this.inuse);

  Map toJson() {
    return {"finished":finished,"task":task,"inuse":inuse};
  }
}