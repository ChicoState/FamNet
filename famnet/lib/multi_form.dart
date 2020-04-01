import 'package:flutter/material.dart';
import 'package:famnet/empty_state.dart';
import 'package:famnet/form.dart';
import 'package:famnet/poll_content.dart';

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
        elevation: .0,
        leading: Icon(
          Icons.wb_cloudy,
        ),
        title: Text('REGISTER USERS'),
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
              Color(0xFF30C1FF),
              Color(0xFF2AA7DC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: polls.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'Add form by tapping add button below',
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
                    title: Text('List of Users'),
                  ),
                  body: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) => ListTile(
                          leading: CircleAvatar(
                            child: Text(data[i].group.substring(0, 1)),
                          ),
                          title: Text(data[i].group),
                          subtitle: Text(data[i].topic),
                        ),
                  ),
                ),
          ),
        );
      }
    }
  }
}