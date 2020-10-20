import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'operation_menu_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Stack(
        children: <Widget>[
          // Center(
          //   child: Column(
          //     children: [
          //       Container(decoration: BoxDecoration(color: Colors.white54),),
          //     ],
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/backgroudRed.jpg"), fit: BoxFit.cover)),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(50),
                    margin: EdgeInsets.only(top: 100, bottom: 100, left: 100),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset('images/PlusLOGO.png', height: 350, width: 350),
                          Text(
                            'API Key Management',
                            style: TextStyle(fontFamily: 'David_Libre', fontSize: 30, color: Colors.white60),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 600,
                    padding: EdgeInsets.all(50),
                    margin: EdgeInsets.only(top: 100, bottom: 100, right: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'David_Libre',
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 50),
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.person),
                                      hintText: 'Enter username',
                                      hintStyle: TextStyle(fontFamily: 'David_Libre'),
                                      labelText: 'Username *',
                                      labelStyle: TextStyle(fontFamily: 'David_Libre'),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter username';
                                      }
                                      return null;
                                    },
                                    // onSaved: (value) {
                                    //   return username = value;
                                    // }, //value = formKey
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.vpn_key),
                                          hintText: 'Enter passward',
                                          hintStyle: TextStyle(fontFamily: 'David_Libre'),
                                          labelText: 'Passward *',
                                          labelStyle: TextStyle(fontFamily: 'David_Libre'),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter password';
                                          }
                                          return null;
                                        },
                                        // onSaved: (value) {
                                        //   return password = value;
                                        // }, //value = formKey
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  child: RaisedButton(
                                    onPressed: () {
                                      final form = formKey.currentState;
                                      if (form.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => OperationMenu()),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(fontSize: 20.0, fontFamily: 'David_Libre', fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
