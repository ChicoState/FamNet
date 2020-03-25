import 'package:flutter/material.dart';

//create a basic form

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  List<String> myGroups = ['Group 1', 'Group 2', 'Group 3'];
  String dropdownValue = 'Group 1';
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormField(
            builder: (FormFieldState state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.group),
                  labelText: 'Group to post poll in',
                ),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: dropdownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: myGroups.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                    ),
                  )
                );
            },
          ),  
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.assessment),
              labelText: "Question or Topic"
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              
              icon: const Icon(Icons.create),
              labelText: "Option 1",
              
            ),
            validator: (value) {
              if(value.isEmpty) {
                return 'Please provide an option';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: const Icon(Icons.create),
              labelText: "Option 2"
            ),
            validator: (value) {
              if(value.isEmpty) {
                return 'Please provide an option';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Submitted Poll')));
                }
              },
              child: Text('Create Poll'),
            ),
          ),
        ],
      ),
    );
  }
}