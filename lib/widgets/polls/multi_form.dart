// //multi_form.dart
// //allows for creation, saving, deleting of multiple polls

import 'package:flutter/material.dart';
import 'package:famnet/widgets/polls/empty_state.dart';
import 'package:famnet/widgets/polls/form.dart';
import 'package:famnet/first_screen.dart';
import 'package:famnet/widgets/polls/poll_content.dart';

class PollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi Form',
      darkTheme: ThemeData.dark(),
      home: new MultiForm()
    );
  }
}

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<PollForm> polls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Polls'
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
        onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirstScreen())); },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0X000000),
              Color(0X000000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: polls.length <= 0
            ? Center(
                child: EmptyState(
                  title: "Oops, you don't have any polls yet",
                  message: 'Create a new poll by tapping add button below',
                ),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: polls.length,
                itemBuilder: (_, i) => polls[i],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: onAddForm,
        foregroundColor: Colors.white,
      ),
    );
  }

  ///on form user deleted
  void onDelete(Poll _poll) {
    setState(() {
      var find = polls.firstWhere(
        (it) => it.poll == _poll,
        orElse: () => null,
      );
      if (find != null) polls.removeAt(polls.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _poll = Poll();
      polls.add(PollForm(
        poll: _poll,
        onDelete: () => onDelete(_poll),
      ));
    });
  }

  ///on save forms
  void onSave() {
    if (polls.length > 0) {
      var allValid = true;
      polls.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        var data = polls.map((it) => it.poll).toList();
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => Scaffold(
                  appBar: AppBar(
                    title: Text('List of Polls'),
                  ),
                  body: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) => ListTile(
                          title: Text(data[i].group),
                          subtitle: Text(data[i].topic),
                          trailing: Text(data[i].option),
                        ),
                  ),
                ),
          ),
        );
      }
    }
  }
}