import 'dart:convert';

import 'package:dataverse/models/account.dart';

class Failure {
  String message;
  Failure(this.message);
}

class ApiResponse {
  List<Account> value;
  ApiResponse({
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value.map((x) => x.toMap()).toList(),
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      value: List<Account>.from(map['value']?.map((x) => Account.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source));
}
