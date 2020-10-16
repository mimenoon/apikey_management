import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ToServicePageButton extends StatelessWidget {
  final Function onPress;
  final String buttonTitle;

  ToServicePageButton({@required this.onPress, @required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ButtonTheme(
        // minWidth: 250,
        // height: 28,
        buttonColor: Colors.transparent,
        child: RaisedButton(
          onPressed: onPress,
          child: Column(
            children: [
              Text(
                buttonTitle,
                maxLines: 1,
                style: TextStyle(color: KletterColor, fontSize: 40, fontFamily: 'PT_Sans'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Describe the information of the specific file',
                maxLines: 1,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans', fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.arrow_forward_sharp,
                size: MediaQuery.of(context).size.height * 0.04,
                color: KletterColor,
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
        ),
      ),
    );
  }
}
