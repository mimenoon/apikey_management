import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FileService {
  FileService();

  static Future<void> writeToFile(Uint8List data) async {
    // final response = await http.get(API);
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'secure.db';
    html.document.body.children.add(anchor);

    anchor.click();

    html.document.body.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
