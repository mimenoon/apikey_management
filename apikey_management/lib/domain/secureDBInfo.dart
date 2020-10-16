import 'dart:core';

import 'dart:core';

class ApiKeyInfo {
  String generatedTimestamp;
  String user;
  String role;
  String module;
  String expireDate;
  String apikey;

  ApiKeyInfo({this.generatedTimestamp, this.user, this.role, this.module, this.expireDate, this.apikey});

  factory ApiKeyInfo.fromJson(Map<String, dynamic> parsedJson) {
    return ApiKeyInfo(
      generatedTimestamp: parsedJson['generatedTimestamp'],
      user: parsedJson['user'],
      role: parsedJson['role'],
      module: parsedJson['module'],
      expireDate: parsedJson['expireDate'],
      apikey: parsedJson['apikey'],
    );
  }
}

class SecureDBInfo {
  String secureExpire;
  bool expired;
  final List<ApiKeyInfo> apiKeyInfos;

  SecureDBInfo({this.secureExpire, this.apiKeyInfos, this.expired});

  factory SecureDBInfo.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['apiKeyInfos'] as List;
    List<ApiKeyInfo> apiKeyInfosList = list.map((i) => ApiKeyInfo.fromJson(i)).toList();

    return new SecureDBInfo(secureExpire: parsedJson['secureExpire'], apiKeyInfos: apiKeyInfosList, expired: parsedJson['expired']);
  }
}
