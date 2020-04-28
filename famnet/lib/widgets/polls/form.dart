import 'package:flutter/material.dart';
import 'package:famnet/widgets/polls/poll_content.dart';


class PollForm extends StatefulWidget {
  final Poll poll;
  final state = _PollFormState();
  // final OnDelete onDelete;

  PollForm({Key key, this.poll}) : super(key: key);
  @override
  _PollFormState createState() => state;
  bool isValid() => state.validate();
}

class _PollFormState extends State<PollForm> {
  final form = GlobalKey<FormState>();

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
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }//validate()

  void _add() {
    _children = List.from(_children)
      ..add(TextFormField(
        decoration: InputDecoration(hintText: "This is TextField ${_count}"),
      ));
    setState(() => ++_count);
  }
}

// //form.dart
// //builds each individual form for polls

// import 'package:flutter/material.dart';
// import 'package:famnet/widgets/polls/poll_content.dart';

// typedef OnDelete();


// class PollForm extends StatefulWidget {
//   final Poll poll;
//   final state = _PollFormState();
//   final OnDelete onDelete;

//   PollForm({Key key, this.poll, this.onDelete}) : super(key: key);
//   @override
//   _PollFormState createState() => state;
//   bool isValid() => state.validate();
// }

// class _PollFormState extends State<PollForm> {
//   final form = GlobalKey<FormState>();
//   List<Widget> _children = [];
//   int _count = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Group'),
//         backgroundColor: Colors.redAccent,
//       ),
//       // body: FormDemo(),
//     );
//   }


//   // Widget _buildPoll() {
//   //   return Padding(
//   //     padding: EdgeInsets.all(16),
//   //     child: Material(
//   //       elevation: 1,
//   //       clipBehavior: Clip.antiAlias,
//   //       borderRadius: BorderRadius.circular(8),
//   //       child: Form(
//   //         key: form,
//   //         child: Column(
//   //           mainAxisSize: MainAxisSize.min,
//   //           children: _children,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   ///form validator
//   bool validate() {
//     var valid = form.currentState.validate();
//     if (valid) form.currentState.save();
//     return valid;
//   }//validate()

//   Widget _buildAppBar() {
//     return AppBar(
//       leading: Icon(Icons.verified_user),
//       elevation: 0,
//       title: Text('Create a new poll'),
//       backgroundColor: Theme.of(context).accentColor,
//       centerTitle: true,
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.delete),
//           onPressed: widget.onDelete,
//         )
//       ],
//     );
//   }



//   void _add() {

//   }
// }
//     // return Padding(
//     //   padding: EdgeInsets.all(16),
//     //   child: Material(
//     //     elevation: 1,
//     //     clipBehavior: Clip.antiAlias,
//     //     borderRadius: BorderRadius.circular(8),
//     //     child: Form(
//     //       key: form,
//     //       child: Column(
//     //         mainAxisSize: MainAxisSize.min,
//     //         children: <Widget>[
//     //           _buildAppBar(),
//     //           // _buildGroupField(),
//     //           // _buildTopicField(),
//     //           _buildOptionsField(),
              
//               // Padding(
//               //   padding: EdgeInsets.only(left: 16, right: 16, top: 16),
//               //   child: TextFormField(
//               //     initialValue: widget.poll.group,
//               //     onSaved: (val) => widget.poll.group = val,
//               //     validator: (val) =>
//               //         val.length > 3 ? null : 'Full name is invalid',
//               //     decoration: InputDecoration(
//               //       labelText: 'Group Name',
//               //       hintText: 'Select a group to post the poll in',
//               //       icon: Icon(Icons.group),
//               //       isDense: true,
//               //     ),
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
//               //   child: TextFormField(
//               //     initialValue: widget.poll.topic,
//               //     onSaved: (val) => widget.poll.topic = val,
//               //     validator: (val) =>
//               //         val.length > 3 ? null : 'Maybe make your topic more descriptive!',
//               //     decoration: InputDecoration(
//               //       labelText: 'Topic or Question',
//               //       hintText: 'Enter a topic/question for the poll',
//               //       icon: Icon(Icons.assessment),
//               //       isDense: true,
//               //     ),
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
//               //   child: TextFormField(
//               //     onSaved: (val) {
//               //       addOption(val);
//               //       widget.poll.option = val;
//               //     },
//               //     decoration: InputDecoration(
//               //       labelText: 'Option ',
//               //       hintText: 'Add a response option ',
//               //       icon: Icon(Icons.create),
//               //       isDense: true,
//               //     ),
//               //   ),
//               // ),
//               // Padding(
//               //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
//               //   child: FloatingActionButton(
//               //     onPressed: _addOptionItem,
//               //     child: new Icon(Icons.add),
//               //   )
//               //   // child: TextFormField(
//               //   //   onSaved: (val) {
//               //   //     addOption(val);
//               //   //     widget.poll.option = val;
//               //   //   },
//               //   //   decoration: InputDecoration(
//               //   //     labelText: 'Option ',
//               //   //     hintText: 'Add a response option ',
//               //   //     icon: Icon(Icons.create),
//               //   //     isDense: true,
//               //   //   ),
//               //   // ),
//               // ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

  

//   // Widget _buildGroupField() {
//   //   // return TextFormField
//   // }

//   // Widget _buildTopicField() {

//   // }

//   // Widget _buildOptionsField() {
//   //   return TextFormField(
//   //     onSaved: (val) {
//   //       addOption(val);
//   //       widget.poll.option = val;
//   //     },
//   //     decoration: InputDecoration(
//   //       labelText: 'Option ',
//   //       hintText: 'Add a response option ',
//   //       icon: Icon(Icons.create),
//   //       isDense: true,
//   //     )
//   //   );
//   // }
  

//   // void addOption(String option) {
//   //   setState(() => widget.poll.options.add(option));
//   //   print(widget.poll.options[0]);
//   // }//addOption()

//   // void _addOptionItem() {
//   //   print("meme");
//   //   new MaterialPageRoute(
//   //     builder: (context) {
//   //       return new Padding(
//   //         padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
//   //         child: TextFormField(
//   //           onSaved: (val) {
//   //             addOption(val);
//   //             widget.poll.option = val;
//   //           },
//   //           decoration: InputDecoration(
//   //             labelText: 'Option ',
//   //             hintText: 'Add a response option ',
//   //             icon: Icon(Icons.create),
//   //             isDense: true,
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   );
//   // }
//   // void _addOptionItem(String option) {
//   //   setState(() {
//   //     widget.poll.options.add(option);
//   //   });
//   // }//_addOptionItem()

