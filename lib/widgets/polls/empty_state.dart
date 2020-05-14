//empty_state.dart
//this is what is displayed if no polls have been created

import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title, message;
  EmptyState({this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 16,
      color: Theme.of(context).cardColor.withOpacity(.95),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ],
        ),
      ),
    );
  }
}