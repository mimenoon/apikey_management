import 'package:apikey/screens/operation_menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onPressed;
  final String buttonTitle;

  LoginButton({@required this.onPressed, @required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OperationMenu()),
          );
        },
        child: Text(
          buttonTitle,
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'David_Libre',
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
