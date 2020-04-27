import 'package:famnet/widgets/polls/multi_form.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_in.dart';
import 'widgets/todo.dart';
import 'widgets/calendar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:famnet/widgets/groups.dart';
import 'package:google_sign_in/google_sign_in.dart';


GoogleSignInAccount currentUser = googleSignIn.currentUser;
String userId = currentUser.id;

final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(Icons.account_circle)),
    new Tab(icon: new Icon(Icons.rss_feed)),
    new Tab(icon: new Icon(Icons.group)),
]);


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
//              Text(
//                'User ID : ',
//                style: TextStyle(
//                  fontSize: 15,
//                  fontWeight: FontWeight.bold,
//                  color: Colors.black26,
//                )
//              ),
//              Text(userId,style: TextStyle(fontSize: 15, color: Colors.deepOrange),),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10
              ),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return LoginPage();
                  }),
                      ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
        floatingActionButton: FabCircularMenu(children:<Widget>[
          IconButton(icon:Icon(Icons.home), onPressed:() {print('Home');}),
          IconButton(icon:Icon(Icons.favorite), onPressed: () {print('Favorite');}),
          IconButton(icon:Icon(Icons.assignment), onPressed: () { runApp(new TodoApp());}),
          IconButton(icon:Icon(Icons.poll), onPressed: () {runApp(new PollApp());}),
//          IconButton(icon:Icon(Icons.home), onPressed:() {print('Home');}),
//          IconButton(icon:Icon(Icons.favorite), onPressed: () {print('Favorite');}),
          IconButton(icon:Icon(Icons.group), onPressed: () {/*runApp(new Groups());*/
            Navigator.push(context, new MaterialPageRoute(builder: (context) => Groups()
            ));
          }),
          IconButton(icon:Icon(Icons.assignment), onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => TodoList()
            ));
          },),
          IconButton(icon:Icon(Icons.poll), onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => PollApp()
            ));
          },),
          IconButton(icon:Icon(Icons.calendar_today), onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => Calendar()
            ));
          },),
        ])
    );
  }
}
