import 'dart:html';

class FileDomain {
  File httpEntity;

  FileDomain({this.httpEntity});

  factory FileDomain.fromJson(Map<String, dynamic> parsedJson) {
    return FileDomain(httpEntity: parsedJson['httpEntity']);
  }
}
