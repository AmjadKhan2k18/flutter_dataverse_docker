import 'dart:convert';
import 'package:dataverse/resources/config.dart';
import 'package:dataverse/resources/pref_util.dart';
import 'package:flutter/foundation.dart';
import 'package:dataverse/models/account.dart';
import 'package:flutter_aad_oauth/flutter_aad_oauth.dart';
import 'package:flutter_aad_oauth/model/config.dart';

const scope = ConfigAPI.url + "/.default";

final currentUri = Uri.base;
final redirectUri = Uri(
  host: currentUri.host,
  scheme: currentUri.scheme,
  port: currentUri.port,
  path: '/authRedirect.html',
);

enum AuthStatus {
  unInitialized,
  authenticated,
  unAuthenticated,
}

class Auth with ChangeNotifier {
  String? accessToken;
  late Config config;
  late FlutterAadOauth oauth;

  AuthStatus _status = AuthStatus.unInitialized;
  String? _error;

  AuthStatus get status => _status;
  String? get error => _error;

  Auth.instance() {
    checkAuth();
  }

  checkAuth() async {
    accessToken = await PreferenceUtils.getString('accessToken');
    if (accessToken == null) {
      _status = AuthStatus.unAuthenticated;
    } else {
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  Future<void> login(context) async {
    config = Config(
      azureTenantId: ConfigAPI.azureTenantId,
      clientId: ConfigAPI.clientId,
      scope: scope,
      resource: ConfigAPI.url,
      redirectUri: ConfigAPI.redirectUrl,
      responseType: 'token',
    );

    oauth = FlutterAadOauth(config);
    oauth.setContext(context);
    checkIsLogged();
    try {
      await oauth.login();
      accessToken = await oauth.getAccessToken();
      _status = AuthStatus.authenticated;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<bool> checkIsLogged() async {
    if (await oauth.tokenIsValid()) {
      accessToken = await oauth.getAccessToken();
      return true;
    } else {
      return false;
    }
  }

  List<Account> parseAccount(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;

    var accounts = list.map((e) => Account.fromJson(e)).toList();
    return accounts;
  }
}
