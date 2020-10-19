import 'dart:ui';

import 'package:apikey/components/to_service_page_button.dart';

import 'package:apikey/screens/register_screen.dart';
import 'package:apikey/screens/rovoke_screen.dart';
import 'package:flutter/material.dart';

import 'describe_screen.dart';
import 'login_screen.dart';

class OperationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/backgroudRed.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Image.asset('images/PlusLOGO.png'),
            title: Center(
                child: Text(
              'API Key Management : Operation Menu',
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PT_Sans'),
            )),
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 360,
                      height: 235,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        // image: DecorationImage(
                        //     image: AssetImage('images/blackPink.jpg'),
                        //     fit: BoxFit.cover),
                      ),
                      child: ToServicePageButton(
                        buttonTitle: 'Describe',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Describe()),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 360,
                      height: 235,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        // borderRadius: BorderRadius.all(Radius.circular(20)),
                        // image: DecorationImage(
                        //     image: AssetImage('images/blackPink.jpg'),
                        //     fit: BoxFit.cover),
                      ),
                      child: ToServicePageButton(
                        buttonTitle: 'Register',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 360,
                      height: 235,
                      // width: MediaQuery.of(context).size.width * 0.23,
                      // height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        // image: DecorationImage(
                        //     image: AssetImage('images/blackPink.jpg'),
                        //     fit: BoxFit.cover),
                      ),
                      child: ToServicePageButton(
                        buttonTitle: 'Revoke',
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Revoke()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
