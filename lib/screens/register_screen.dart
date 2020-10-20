import 'dart:html';
import 'dart:typed_data';

import 'package:apikey/components/enter_button.dart';
import 'package:apikey/components/selectfile_button_container.dart';
import 'package:apikey/service/downloadFile_service.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alert_dialog_screen.dart';
import 'operation_menu_screen.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  final formInputKey = GlobalKey<FormState>();
  Pattern patternSpecialChar = r'^[a-zA-Z0-9\-_]+$';
  Pattern patternExpireDate = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
  String inputFileName = '';
  String resultFileName = '';
  String url = '';
  String secret = '';
  String file = '';
  String secretExpire = '';
  String user = '';
  String role = '';
  String module = '';
  String expireDate = '';
  Uint8List inputFile;
  Row resultFile = Row(
    children: [Text('No data, please enter valid input.', style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'))],
  );

  final DownloadFileService downloadFileService = DownloadFileService();
  Uint8List uploadedFile;

  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  void scrollCallBack(DragUpdateDetails dragUpdate) {
    setState(() {
      _controller.position.moveTo(dragUpdate.globalPosition.dy * 3.5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/backgroudRed.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Image.asset('images/PlusLOGO.png'),
            title: Center(
              child: Text(
                'API Key Management : Register Service',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PT_Sans'),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OperationMenu()),
                  );
                },
              ),
            ],
          ),
          body: DraggableScrollbar.rrect(
            alwaysVisibleScrollThumb: true,
            controller: _controller,
            heightScrollThumb: 100,
            child: ListView.builder(
              controller: _controller,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(50),
                  margin: EdgeInsets.only(top: 40, left: 200, right: 200, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: KformColor,
                    // image: DecorationImage(
                    //     image: AssetImage('images/backgroundCool.jpg'),
                    //     fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Enter Input',
                                style: TextStyle(color: KheadColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
                              ),
                            ),
                            Form(
                              key: formInputKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(20),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.assignment),
                                              hintText: 'Example: plusitsolution',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'Secret *',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternSpecialChar);
                                              if (value.isEmpty) {
                                                return 'Please enter secret';
                                              }
                                              if (!regexSpecialChar.hasMatch(value)) {
                                                return 'Cannot enter special characters and space';
                                              }
                                              secret = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.timer),
                                              hintText: 'Example: 2023-04-30',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'Secret expire',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternExpireDate);
                                              if (value != '') {
                                                if (!regexSpecialChar.hasMatch(value)) {
                                                  return 'Secret expire must be in format yyyy-mm-dd';
                                                }
                                              }
                                              secretExpire = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.person_outline),
                                              hintText: 'Example: anyuser',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'User *',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternSpecialChar);
                                              if (value.isEmpty) {
                                                return 'Please enter user';
                                              }
                                              if (!regexSpecialChar.hasMatch(value)) {
                                                return 'Cannot enter special characters and space';
                                              }
                                              user = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.people),
                                              hintText: 'Example: DEV',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'Role *',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternSpecialChar);
                                              if (value.isEmpty) {
                                                return 'Please enter role';
                                              }
                                              if (!regexSpecialChar.hasMatch(value)) {
                                                return 'Cannot enter special characters and space';
                                              }
                                              role = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.view_module),
                                              hintText: 'Example: AI',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'Module *',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternSpecialChar);
                                              if (value.isEmpty) {
                                                return 'Please enter module';
                                              }
                                              if (!regexSpecialChar.hasMatch(value)) {
                                                return 'Cannot enter special characters and space';
                                              }
                                              module = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 300,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              icon: Icon(Icons.timer),
                                              hintText: 'Example: 2100-11-31',
                                              hintStyle: TextStyle(fontFamily: 'Lato'),
                                              labelText: 'Expire date *',
                                              labelStyle: TextStyle(fontFamily: 'Lato'),
                                            ),
                                            validator: (value) {
                                              RegExp regexSpecialChar = new RegExp(patternExpireDate);
                                              if (value.isEmpty) {
                                                return 'Please enter Expire date';
                                              }
                                              if (!regexSpecialChar.hasMatch(value)) {
                                                return 'Secret expire must be in format yyyy-mm-dd';
                                              }
                                              expireDate = value;
                                              return null;
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'SecureDB ',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
                                        ),
                                        GestureDetector(
                                          child: RawMaterialButton(
                                            elevation: 8,
                                            highlightElevation: 2,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            onPressed: () async {
                                              InputElement uploadInput = FileUploadInputElement();
                                              uploadInput.click();
                                              uploadInput.onChange.listen((e) {
                                                // read file content as dataURL
                                                final files = uploadInput.files;
                                                if (files.length == 1) {
                                                  final file = files[0];
                                                  FileReader reader = FileReader();
                                                  reader.onLoadEnd.listen((e) {
                                                    setState(() {
                                                      inputFileName = files[0].name;
                                                      uploadedFile = reader.result;
                                                      // print('file size = ' + uploadedFile.lengthInBytes.toString());
                                                    });
                                                  });

                                                  reader.onError.listen((fileEvent) {
                                                    print("Some Error occurred while reading the file");
                                                  });

                                                  reader.readAsArrayBuffer(file);
                                                }
                                              });
                                              setState(() {});
                                            },
                                            child: SelectFileButtonContainer(),
                                          ),
                                        ),
                                        Text(
                                          inputFileName,
                                          style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
                                        ),
                                        //
                                        Icon(
                                          Icons.insert_drive_file,
                                          color: KheadColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    GestureDetector(
                                      child: RawMaterialButton(
                                        elevation: 8,
                                        highlightElevation: 2,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        onPressed: () {
                                          final form = formInputKey.currentState;
                                          if (!form.validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialogScreen(
                                                    title: "Please enter all input", content: "Please enter all required input correctly");
                                              },
                                            );
                                          } else if (form.validate()) {
                                            downloadFileService.fileUploadRegister(
                                                secret, uploadedFile, secretExpire, user, role, module, expireDate);
                                            setState(() {});
                                          }
                                          return null;
                                        },
                                        child: EnterButton(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
