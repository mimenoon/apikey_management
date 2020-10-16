import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CopyButton extends StatelessWidget {
  String apikey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF05F5F),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          'Copy Apikey',
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Lato',
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.red,
                offset: Offset(5.0, 5.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
