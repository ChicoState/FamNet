import 'package:flutter/material.dart';


class PollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Polls',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: new Poll()
    );
  }
}

class Poll extends StatefulWidget {
  @override
  _PollState createState() => new _PollState();
}

class _PollState extends State<Poll> {
  List<Widget> _children = [];
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
        actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: _add)],
      ),
      body: ListView(children: _children),
    );
  }
  // bool validate() {
  //   var valid = form.currentState.validate();
  //   if (valid) form.currentState.save();
  //   return valid;
  // }//validate()

  void _add() {
    _children = List.from(_children)
      ..add(TextFormField(
        decoration: InputDecoration(hintText: "This is TextField ${_count}"),
      ));
    setState(() => ++_count);
  }
}