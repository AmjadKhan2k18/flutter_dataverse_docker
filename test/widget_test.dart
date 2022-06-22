import 'dart:convert';

import 'package:dataverse/models/response.dart';
import 'package:dataverse/providers/accounts.dart';
import 'package:dataverse/providers/auth.dart';
import 'package:dataverse/resources/api_provider.dart';
import 'package:dataverse/screens/login.dart';
import 'package:dataverse/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

import 'test_data.dart';

void main() {
  testWidgets('LoginScreen has Signing in please wait! text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider.value(value: Auth.instance()),
    ], child: const MaterialApp(home: LoginScreen())));

    // Create the Finders.
    final waitTextFinder = find.text('Signing in please wait!');
    expect(waitTextFinder, findsOneWidget);
  });

  testWidgets('SearchScreen has searchfield', (WidgetTester tester) async {
    const searchTxt = "Hello World";
    final searchField = find.byKey(const Key('search_field'));

    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider.value(value: AccountsState('')),
    ], child: const MaterialApp(home: SearchScreen())));

    await tester.enterText(searchField, searchTxt);

    expect(find.text(searchTxt), findsOneWidget);
    expect(searchField, findsOneWidget);
  });

  testWidgets(
    'AccountsListView has data',
    (WidgetTester tester) async {
      final apiProvider = ApiProvider();
      apiProvider.client = MockClient(
        (request) async {
          return Response(jsonEncode(TestData.successJson), 200);
        },
      );

      final response =
          await apiProvider.fetchAccounts('http://testUrl.com', {});

      response.fold((failure) => expect(failure, isA<Failure>()),
          (success) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CustomScrollView(
              slivers: [
                AccountsListView(
                  accounts: success,
                ),
              ],
            ),
          ),
        );

        final findText = find.text(TestData.successJson['value'][0]['name']);

        expect(findText, findsOneWidget);
      });
    },
  );

  testWidgets(
    'AccountsGridView has data',
    (WidgetTester tester) async {
      final apiProvider = ApiProvider();
      apiProvider.client = MockClient(
        (request) async {
          return Response(jsonEncode(TestData.successJson), 200);
        },
      );

      final response =
          await apiProvider.fetchAccounts('http://testUrl.com', {});

      response.fold((failure) => expect(failure, isA<Failure>()),
          (success) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CustomScrollView(
              slivers: [
                AccountsGridView(
                  accounts: success,
                ),
              ],
            ),
          ),
        );

        final findText = find.text(TestData.successJson['value'][0]['name']);

        expect(findText, findsOneWidget);
      });
    },
  );
}
