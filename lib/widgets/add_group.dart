import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:famnet/sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignInAccount currentUser = googleSignIn.currentUser;
String TUID = currentUser.id;

class addGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group'),
        backgroundColor: Colors.redAccent,
      ),
      body: FormDemo(),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}
//Holds the form information
class FormDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormDemoState();
  }
}
//Creates the form. Can be exanded on.
class _FormDemoState extends State<FormDemo> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'Gname': null, 'Description': null, 'Owner':null};
  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNameField(),
            _buildDescriptionField(),
            _buildSubmitButton(),
          ],
        ));
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Group Name'),
      validator: (String value) {
        if(value=="")
          return 'This is not a valid name';
      },
      onSaved: (String value) {
        _formData['Gname'] = value;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focusPassword);
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Short Description'),
      validator: (String value) {
        if (value.isEmpty) {
          return "empty";
        }
      },
      onSaved: (String value) {
        _formData['Description'] = value;
      },
      focusNode: focusPassword,
      onFieldSubmitted: (v) {
        _submitForm();
      },
    );
  }
  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        _submitForm();
      },
      child: Text('SEND'),
    );
  }
  //Saves the data and returns to previous screen
  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _saveData(new Gcreation(_formData['Gname'], _formData['Description']));
      Navigator.pop(context);

    }
  }
}
final databaseReference = FirebaseDatabase.instance.reference();

void _saveData(Gcreation group) async {
  final FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  group.setOwner(uid);
  var json = group.toJson();

  databaseReference.child("groups").push().set(json);
  String newkey = databaseReference.child("groupData").push().key;
  databaseReference.child("groupData").child(newkey).set({"Gname":group.Gname});
  String UID= TUID;
  databaseReference.child("groupData").child(newkey).child("UIDS").push().set({"uid":UID});
  print("The user is " +TUID);
  print("The key is " + newkey);
}
//Class that holds groups information between user entering it and it being submitted.
class Gcreation {
  String Gname;
  String Description;
  String Owner;

  Gcreation(this.Gname,this.Description);
//Returns class as a map which can then be used to send as json
  Map toJson() {
    return {"Gname":Gname,"Description":Description,"Owner":Owner};
  }
  void setOwner(String Owner)
  {
    this.Owner=Owner;
  }
}
