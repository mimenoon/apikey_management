import 'dart:convert';
import 'dart:typed_data';

import 'package:apikey/domain/secureDBInfo.dart';
import 'package:apikey/screens/alert_dialog_screen.dart';
import 'package:http/http.dart' as http;

class SecureDBInfoService {
  SecureDBInfoService();

  static const API = 'http://192.168.80.1:9000/apikeymanagement/secure/admin/describe?secret=';

  String username = 'admin';
  String password = 'plus1234';

  Future<SecureDBInfo> fileUpload(String secret, Uint8List file) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    // plusitsolution
    try {
      var request = http.MultipartRequest('POST', Uri.parse(API + secret));
      request.headers.addAll({'authorization': basicAuth});
      request.files.add(
        http.MultipartFile.fromBytes('secureDB', file, filename: "secure.db"),
      );
      // print('This is header' + request.headers.toString());
      var response = await request.send(); //.timeout(Duration(seconds: 120));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseByteArray = await response.stream.toBytes();
        return SecureDBInfo.fromJson(json.decode(utf8.decode(responseByteArray)));
      } else {
        throw Exception('Failed to post multipart file');
      }
    } catch (ex) {
      print(ex);
      throw Exception(AlertDialogScreen(title: "Please enter all input", content: "Please enter secret"));
    }
  }
}
