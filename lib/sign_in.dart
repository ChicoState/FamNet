import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

Queue q;

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


var groups = {};
String authId;
String name;
String email;
String imageUrl;



Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.uid != null);
  assert(user.email != null);
  assert(user.displayName != null);
  if(user.photoUrl == null){
    imageUrl = "https://www.google.com/logos/doodles/2020/stay-and-play-at-home-with-popular-past-google-doodles-halloween-2016-6753651837108773-s.png";
  }
  else{
    imageUrl = user.photoUrl;
  }
  authId = user.uid;
  name = user.displayName;
  email = user.email;
  
  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  databaseReference.child("users").update({"UID":authId});
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}


class UserData {
  String userDataUid = authId;
  Queue userGroups;
  UserData(this.userGroups);

  Map toJson() {
    return {"User_ID":userDataUid, "groups_apart":userGroups};
  }
}