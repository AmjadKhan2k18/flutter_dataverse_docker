import 'dart:convert';

import 'package:dataverse/models/account.dart';
import 'package:dataverse/models/response.dart';
import 'package:dataverse/resources/api_provider.dart';
import 'package:dataverse/resources/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'test_data.dart';

void main() {
  const url =
      '${ConfigAPI.url}/api/data/v9.1/accounts?\$select=name,accountnumber,statecode,address1_stateorprovince';

  test("Test Account API with success response", () async {
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient(
      (request) async {
        return Response(jsonEncode(TestData.successJson), 200);
      },
    );

    final response = await apiProvider.fetchAccounts(url, {});

    response.fold(
      (failure) => expect(failure, isA<Failure>()),
      (success) {
        expect(success, isA<List<Account>>());
        expect(success.length, equals(3));
      },
    );
  });

  test("Test Account API with failure response", () async {
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient(
      (request) async {
        return Response(jsonEncode(TestData.failureJson), 200);
      },
    );

    final response = await apiProvider.fetchAccounts(url, {});

    response.fold(
      (failure) => expect(failure, isA<Failure>()),
      (success) => expect(success, isA<List<Account>>()),
    );
  });
}
