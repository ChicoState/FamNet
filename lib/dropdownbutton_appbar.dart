import 'package:flutter/material.dart';

class KeyValuePairDropdown extends StatefulWidget {
  @override
  KeyValuePairDropdownState createState() {
    return new KeyValuePairDropdownState();
  }
}

class KeyValuePairDropdownState extends State<KeyValuePairDropdown> {
  final List<String> _dropdownValues = [
    "My Family",
    "Grandpa/Grandma",
    "Cousins",
  ]; //The list of values we want on the dropdown
  String _currentlySelected = ""; //var to hold currently selected value

  //make the drop down its own widget for readability
  Widget dropdownWidget() {
    return DropdownButton(
      //map each value from the lIst to our dropdownMenuItem widget
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
        child: Text(value),
        value: value,
      ))
          .toList(),
      onChanged: (String value) {
        //once dropdown changes, update the state of out currentValue
        setState(() {
          _currentlySelected = value;
        });
      },
      //this wont make dropdown expanded and fill the horizontal space
      isExpanded: false,
      //make default value of dropdown the first value of our list
      value: _dropdownValues.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FamNet'),
        actions: <Widget>[
          //Add the dropdown widget to the `Action` part of our appBar. it can also be among the `leading` part
          dropdownWidget(),
        ],
      ),
      //display currently selected item on dropdown
      body: Center(child: Text(_currentlySelected)),
    );
  }
}