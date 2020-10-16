import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'fileService.dart';

class DownloadFileService {
  DownloadFileService();

  static const API_Revoke = 'http://192.168.86.39:9000/apikeymanagement/secure/admin/revoke?secret=';
  static const API_Register = 'http://192.168.86.39:9000/apikeymanagement/secure/admin/register?secret=';

  String username = 'admin';
  String password = 'plus1234';

  void fileUploadRegister(String secret, Uint8List file, String secretExpire, String user, String role, String module, String expireDate) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    // plusitsolution
    try {
      var request;
      if (secretExpire != '') {
        print('here 1');
        request = http.MultipartRequest(
            'POST',
            Uri.parse(API_Register +
                secret +
                '&secretExpire=$secretExpire' +
                '&user=$user' +
                '&role=$role' +
                '&module=$module' +
                '&expireDate=$expireDate'));
      } else {
        print('here 2');
        request = http.MultipartRequest(
            'POST', Uri.parse(API_Register + secret + '&user=$user' + '&role=$role' + '&module=$module' + '&expireDate=$expireDate'));
      }
      print('here 3');
      request.headers.addAll({'authorization': basicAuth});
      print('This is header ' + request.headers.toString());
      if (file != null) {
        request.files.add(http.MultipartFile.fromBytes('secureDB', file, filename: "secure.db"));
      }

      var response = await request.send(); //.timeout(Duration(seconds: 120));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseByteArray = await response.stream.toBytes();
        // print(SecureDBInfo.fromJson(json.decode(utf8.decode(responseByteArray))).apiKeyInfos[0].user);
        await FileService.writeToFile(responseByteArray);
      } else {
        throw Exception('Failed to post multipart file');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Time out');
    }
  }

  void fileUploadRevoke(String secret, Uint8List file, String apikey, String secretExpire) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);
    // plusitsolution
    try {
      var request;
      if (secretExpire != '') {
        request = http.MultipartRequest('POST', Uri.parse(API_Revoke + secret + '&secretExpire=$secretExpire'));
      } else {
        request = http.MultipartRequest('POST', Uri.parse(API_Revoke + secret));
      }
      request.headers.addAll({'authorization': basicAuth, 'apikey': apikey});
      request.files.add(http.MultipartFile.fromBytes('secureDB', file, filename: "secure.db"));
      // print(request.headers);
      var response = await request.send(); //.timeout(Duration(seconds: 120));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var responseByteArray = await response.stream.toBytes();
        // print(SecureDBInfo.fromJson(json.decode(utf8.decode(responseByteArray))).apiKeyInfos[0].user);
        await FileService.writeToFile(responseByteArray);
      } else {
        throw Exception('Failed to post multipart file');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Time out');
    }
  }
}
