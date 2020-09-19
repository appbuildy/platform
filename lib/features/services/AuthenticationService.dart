import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/features/entities/CurrentUser.dart';
import 'package:flutter_app/features/entities/NotLoggedInUser.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  String _jwtToken;
  String _url;
  http.Client httpClient;
  AuthenticationService({String url, String jwt, http.Client client}) {
    this._url = url;
    this._jwtToken = jwt;
    this.httpClient = client;
  }

  Future<User> authenticate() async {
    final response = await this.httpClient.get(_url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $_jwtToken"});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return CurrentUser(parsed['name'], _jwtToken);
    } else {
      return NotLoggedInUser();
    }
  }
}
