import 'package:apikey/screens/login_screen.dart';
import 'package:apikey/screens/operation_menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primaryColor: Color(0xFF5b5e64),
      // ),
      home: OperationMenu(),
    );
  }
}
