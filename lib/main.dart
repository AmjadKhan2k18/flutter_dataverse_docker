import 'package:dataverse/providers/accounts.dart';
import 'package:dataverse/providers/auth.dart';
import 'package:dataverse/screens/loading.dart';
import 'package:dataverse/screens/login.dart';
import 'package:dataverse/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth.instance()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<Auth>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AccountsState(auth.accessToken)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dataverse in Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppHome(),
      ),
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<Auth>().status;
    switch (state) {
      case AuthStatus.authenticated:
        return const SearchScreen();
      case AuthStatus.unAuthenticated:
        return const LoginScreen();
      default:
        return const LoadingScreen();
    }
  }
}
