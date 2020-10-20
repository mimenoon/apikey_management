// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:apikey/components/enter_button.dart';
import 'package:apikey/components/selectfile_button_container.dart';
import 'package:apikey/domain/secureDBInfo.dart';
import 'package:apikey/result/describe_secureExpire_result.dart';
import 'package:apikey/service/secureDBInfo_service.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'alert_dialog_screen.dart';
import 'operation_menu_screen.dart';

class Describe extends StatefulWidget {
  @override
  _Describe createState() => _Describe();
}

class _Describe extends State<Describe> {
  final formInputKey = GlobalKey<FormState>();
  final Pattern patternSpecialChar = r'^[a-zA-Z0-9\-_]+$';

  String secret;
  String filePath;
  ScrollController _controller;
  String inputFileName = '';
  SecureDBInfo secureDBInfo;
  String strSecureExpire;
  bool expired;
  Row secureExpire = Row(
    children: [Text('')],
  );
  List<ApiKeyInfo> secureDBInfoList;
  Column result = Column(children: [Text(''), Text('')]);
  int count = 0;
  Uint8List uploadedFile;
  String countShow = '';

  final SecureDBInfoService secureDBInfoService = SecureDBInfoService();
  Future<SecureDBInfo> futureSecureDBInfo;

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
                'API Key Management : Describe Service',
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
                                                return 'Cannot enter special characters';
                                              }
                                              secret = value;
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
                                          'SecureDB',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
                                        ),
                                        Text(
                                          ' * ',
                                          style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
                                        ),
                                        GestureDetector(
                                          child: RawMaterialButton(
                                            elevation: 8,
                                            highlightElevation: 2,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                            onPressed: () async {
                                              // FilePickerCross file =
                                              //     await FilePickerCross.importFromStorage(type: FileTypeCross.any, fileExtension: '.txt, .md');
                                              print("press select la");
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
                                                      print('file size = ' + uploadedFile.lengthInBytes.toString());
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
                                        SelectableText(
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
                                        onPressed: () async {
                                          print("press enter la");
                                          final form = formInputKey.currentState;
                                          if (inputFileName == '') {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialogScreen(title: "Please enter all input", content: "Please select input file");
                                              },
                                            );
                                          } else if (!form.validate()) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialogScreen(title: "Please enter all input", content: "Please enter secret");
                                              },
                                            );
                                          } else if (form.validate()) {
                                            futureSecureDBInfo = (await secureDBInfoService.fileUpload(secret, uploadedFile)) as Future<SecureDBInfo>;
                                            if (futureSecureDBInfo == null) {
                                              return AlertDialogScreen(title: "Error", content: "incorrect secret or secureDB");
                                            } else {
                                              setState(() {});
                                            }
                                          }
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
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Result',
                                style: TextStyle(color: KheadColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Lato'),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                          // alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            child: FutureBuilder<SecureDBInfo>(
                              future: futureSecureDBInfo,
                              builder: (context, secureDB) {
                                if (secureDB.hasData) {
                                  secureDBInfoList = secureDB.data.apiKeyInfos;
                                  // print(secureDBInfoList[0].expireDate);
                                  print('has data');
                                  if (secureDBInfoList.length != 0) {
                                    strSecureExpire = secureDB.data.secureExpire;
                                    expired = secureDB.data.expired;
                                    print(secureDB.data.apiKeyInfos[0].apikey);
                                    count = secureDBInfoList.length;
                                    // print(count);
                                    if (count >= 2) {
                                      countShow = count.toString() + ' Results';
                                    } else {
                                      countShow = count.toString() + ' Result';
                                      print(countShow);
                                    }

                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            SecureExpireResult(strSecureExpire: strSecureExpire, expired: expired),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Text(countShow,
                                            style: TextStyle(color: KletterColor, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'PT_Sans')),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            for (int i = 0; i < count; i++) ...[
                                              Container(
                                                // height: (250 * count).toDouble(),
                                                height: 250,
                                                child: SecureDBInfoResult(secureDBInfoList: secureDBInfoList, index: i),
                                              ),
                                            ]
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return Container(
                                  child: Text('No data, please enter valid input.',
                                      style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans')),
                                );
                              },
                            ),
                          ),
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
