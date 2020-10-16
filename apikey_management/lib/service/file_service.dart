import 'dart:html';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FileService {
  FileService();

  static const API = 'http://192.168.86.112:8080/apikey';

  Future<void> writeToFile(ByteData data, String path) async {
    final response = await http.get(API);
    final buffer = data.buffer;
    // return new File(response).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
