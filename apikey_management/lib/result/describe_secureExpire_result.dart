import 'package:apikey/components/copy_button.dart';
import 'package:apikey/domain/secureDBInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class SecureExpireResult extends StatelessWidget {
  final String strSecureExpire;
  final bool expired;

  SecureExpireResult({@required this.strSecureExpire, @required this.expired});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.timer_outlined),
        Text(
          '  SecureExpire:  ',
          style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
        ),
        SelectableText(
          strSecureExpire,
          style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
        ),
        Text(
          '    Expired:  ',
          style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
        ),
        SelectableText(
          expired.toString(),
          style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class SecureDBInfoResult extends StatelessWidget {
  final List<ApiKeyInfo> secureDBInfoList;
  int index;

  SecureDBInfoResult({@required this.secureDBInfoList, @required this.index});

  @override
  Widget build(BuildContext context) {
    void _handleSuccess(dynamic result) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Apikey Copied.'),
        ),
      );
    }

    void _handleError(Object exception) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Fail to copy'),
        ),
      );
    }

    return new Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
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
              Icon(Icons.access_time),
              Text(
                '  GenerateTimestamp:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].generatedTimestamp,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.vpn_key),
              Text(
                '  Api key:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].apikey,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SizedBox(width: 10),
              GestureDetector(
                child: RawMaterialButton(
                  elevation: 8,
                  highlightElevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: secureDBInfoList[index].apikey),
                    ).then(_handleSuccess, onError: _handleError);
                  },
                  child: CopyButton(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person_outline),
              Text(
                '  User:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].user,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.people),
              Text(
                '  Role:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].role,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.vpn_key),
              Text(
                '  Module:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].module,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.timer_rounded),
              Text(
                '  Expire date:   ',
                style: TextStyle(fontWeight: FontWeight.bold, color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
              SelectableText(
                secureDBInfoList[index].expireDate,
                style: TextStyle(color: KletterColor, fontSize: 15, fontFamily: 'PT_Sans'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
