import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogScreen extends StatelessWidget {
  final String title;
  final String content;

  AlertDialogScreen({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
