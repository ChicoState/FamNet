import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'dart:convert';
// import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  createState() => new CalendarState();
}

class CalendarState extends State<Calendar> {
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime,List<dynamic>>.from( decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Calendar',
          key: new Key('calendar')
          ),
        actions: <Widget>[
          //empty button that does nothing
          IconButton(
            onPressed: null,
            icon: Icon(Icons.adb),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              key: new Key("table calender"),
              headerStyle: HeaderStyle(
                formatButtonShowsNext: false,
              ),
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => Card( //display selected days events
              child: InkWell(
                splashColor: Colors.blue,
                onTap: (){
                  _showRemoveDialog(event);
                },
                child: ListTile(
                  title: Text(event),
                  leading: Icon(Icons.star),
                ),
              ),
              elevation: 2.0,

            )),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showRemoveDialog(dynamic event) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text(
            'Remove event "$event"?',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirm"),
              onPressed:(){
                Navigator.pop(context);
                setState(() {
                  _events[_controller.selectedDay].remove(event);
                });
                prefs.setString("events", json.encode(encodeMap(_events)));
                },
            )
          ],
        )
    );
  }



  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text(
          'Add event',
          key:new Key("add_event"),
        ),
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Save"),
            key: new Key("save"),
            onPressed:(){
              if(_eventController.text.isEmpty) return; //if text field is empty
              Navigator.pop(context);
              setState(() {
                if(_events[_controller.selectedDay] != null) {//if there are already events on selected day
                  _events[_controller.selectedDay].add(_eventController.text);
                }
                else{ //if no events on selected day
                  _events[_controller.selectedDay] = [_eventController.text];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
              });
            },
          )
        ],
      )
    );
  }
}
