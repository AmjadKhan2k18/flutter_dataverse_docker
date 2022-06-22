import 'dart:io';

import 'package:dataverse/models/account.dart';
import 'package:dataverse/resources/api_provider.dart';
import 'package:dataverse/resources/config.dart';
import 'package:flutter/material.dart';

class AccountsState with ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  AccountsState(String? token) : apiToken = token {
    if (token == null) return;
    searchAccounts();
  }

  final String? apiToken;
  String? _searchStr;

  String? _error;
  List<Account> _accounts = [];
  String? _stateOrProvince;
  bool _isLoading = false;
  int _state = 2;

  String? get stateOrProvince => _stateOrProvince;
  String? get error => _error;
  String? get searchStr => _searchStr;
  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;
  int get state => _state;

  set searchStr(String? searchValue) {
    _searchStr = searchValue;
    searchAccounts();
  }

  set stateOrProvince(String? selected) {
    _stateOrProvince = selected;
    searchAccounts();
    notifyListeners();
  }

  set state(int newState) {
    _state = newState;
    searchAccounts();
    notifyListeners();
  }

  searchAccounts() async {
    _isLoading = true;
    notifyListeners();
    try {
      String params = getParams();

      String uri =
          '${ConfigAPI.url}/api/data/v9.1/accounts?\$select=name,accountnumber,statecode,address1_stateorprovince' +
              (params == "" ? "" : "&\$filter=" + params);

      final response = await apiProvider.fetchAccounts(uri, getHeader());

      response.fold(
        (failure) => _error = failure.message,
        (success) {
          _accounts = success;
          _error = null;
        },
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getParams() {
    String params = "";
    if (searchStr != null) {
      params +=
          "(contains(name,'$searchStr') or contains(accountnumber,'$searchStr'))";
    }

    if (state != 2) {
      if (params != "") {
        params += " and ";
      }
      params += "(statecode eq $state)";
    }
    if (stateOrProvince != null) {
      if (params != "") {
        params += " and ";
      }
      params += "(address1_stateorprovince eq '$stateOrProvince')";
    }
    return params;
  }

  Map<String, String> getHeader() => {
        HttpHeaders.acceptHeader: "*/*",
        HttpHeaders.hostHeader: "http://localhost:5050/",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $apiToken",
      };
}
