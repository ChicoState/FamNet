//form.dart
//builds each individual form for polls

import 'package:flutter/material.dart';
import 'package:famnet/widgets/polls/poll_content.dart';


typedef OnDelete();

class PollForm extends StatefulWidget {
  final Poll poll;
  final state = _PollFormState();
  final OnDelete onDelete;

  PollForm({Key key, this.poll, this.onDelete}) : super(key: key);
  @override
  _PollFormState createState() => state;
  bool isValid() => state.validate();
}

class _PollFormState extends State<PollForm> {
  final form = GlobalKey<FormState>();
  // final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('Create a new poll'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  initialValue: widget.poll.group,
                  onSaved: (val) => widget.poll.group = val,
                  validator: (val) =>
                      val.length > 3 ? null : 'Full name is invalid',
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    hintText: 'Select a group to post the poll in',
                    icon: Icon(Icons.group),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  initialValue: widget.poll.topic,
                  onSaved: (val) => widget.poll.topic = val,
                  validator: (val) =>
                      val.length > 3 ? null : 'Maybe make your topic more descriptive!',
                  decoration: InputDecoration(
                    labelText: 'Topic or Question',
                    hintText: 'Enter a topic/question for the poll',
                    icon: Icon(Icons.assessment),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  onSaved: (val) => widget.poll.option = val,
                  decoration: InputDecoration(
                    labelText: 'Option ',
                    hintText: 'Add a response option ',
                    icon: Icon(Icons.create),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
