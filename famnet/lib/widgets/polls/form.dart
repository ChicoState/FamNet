//form.dart
//builds each individual form for polls

import 'package:famnet/widgets/polls/multi_form.dart';
import 'package:flutter/material.dart';
import 'package:famnet/widgets/polls/poll_content.dart';

typedef OnDelete();
typedef OnAddOption();

class PollForm extends StatefulWidget {
  final Poll poll;
  final state = _PollFormState();
  final OnDelete onDelete;
  final OnAddOption onAddOption;

  PollForm({Key key, this.poll, this.onDelete, this.onAddOption}) : super(key: key);
  @override
  _PollFormState createState() => state;
  bool isValid() => state.validate();
}

class _PollFormState extends State<PollForm> {
  final form = GlobalKey<FormState>();
  // final myController = TextEditingController();
  List<Widget> _options = [];
  int _count = 1;
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
<<<<<<< HEAD
                  onSaved: (val) {
                    addOption(val);
                    widget.poll.option = val;
                  },
=======
                  // widget.poll.options.add("meme"),
                  onSaved: (val) => widget.poll.option = val,
>>>>>>> upstream/master
                  decoration: InputDecoration(
                    labelText: 'Option ',
                    hintText: 'Add a response option ',
                    icon: Icon(Icons.create),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNewOption,
                ),
              )
              // IconButton(
              //   icon: Icon(Icons.add),
              //   onPressed: _addNewOption,)
            ],
          ),
        ),
      ),
    );
  }

  void _addNewOption() {
    print("meme");
    setState(() {
      widget.poll.options.add("");
    });
  }
  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }

  void addOption(String option) {
    setState(() => widget.poll.options.add(option));
    print(widget.poll.options[0]);
  }
}


