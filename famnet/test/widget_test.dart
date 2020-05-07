// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:famnet/first_screen.dart';
// import 'package:famnet/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:famnet/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../lib/first_screen.dart';
import '../lib/login_page.dart';
import '../lib/main.dart';
import '../lib/sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';



Widget buildTestableWidget(Widget widget) {
  return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
}
void main() {


  testWidgets('Login test', (WidgetTester tester) async {
  
    await tester.pumpWidget(buildTestableWidget(LoginPage()));
    //We're on the login page. There should be an outline button around an image
    //And an image for FamNet's logo.
    expect(find.byType(OutlineButton), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    
    //We click on the button taking us to the First Screen.
    await tester.tap(find.byType(OutlineButton));

    //This will be the "Sign in with google text"
    expect(find.byType(Text), findsOneWidget);

  });
  testWidgets('First Screen Test', (WidgetTester tester) async {
    
    
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // final auth = MockFirebaseAuth();
    // final result = await auth.signInWithCredential(credential);
    name = "JT";
    email = "test@testies.test";
    // // Sign in.


    await tester.pumpWidget(buildTestableWidget(FirstScreen()));    
    // //We're going to go into the
    expect(find.byType(Text), findsWidgets);
    expect(find.byKey(new Key("name")), findsOneWidget);
    expect(find.byKey(new Key("email")), findsOneWidget);
    expect(find.byKey(new Key("signout")), findsOneWidget);
  });
}
