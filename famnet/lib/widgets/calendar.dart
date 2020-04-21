import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  createState() => new CalendarState();
}

class CalendarState extends State<Calendar> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Calendar'),
        actions: <Widget>[
          //empty button that does nothing
          IconButton(
            onPressed: null,
            icon: Icon(Icons.adb),
          ),
        ],
      ),

    );
  }
}