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

  factory AuthenticationService.defaultAuth({String jwt, String url}) {
    return AuthenticationService(jwt: jwt, url: url, client: http.Client());
  }
  AuthenticationService({String url, String jwt, http.Client client}) {
    this._url = url;
    this._jwtToken = jwt;
    this.httpClient = client;
  }

  Future<User> authenticate() async {
    try {
      final response = await this.httpClient.get(_url,
          headers: {HttpHeaders.authorizationHeader: "Bearer $_jwtToken"});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        return CurrentUser(parsed['name'], _jwtToken, this._url,
            email: parsed['email']);
      } else {
        return NotLoggedInUser();
      }
    } catch (e) {
      return NotLoggedInUser();
    }
  }
}
