import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'User.dart';

class CurrentUser extends User {
  String _name;
  String _jwtToken;
  String dataUrl;

  CurrentUser(this._name, this._jwtToken, this.dataUrl);

  Map<String, String> authHeaders() {
    return {HttpHeaders.authorizationHeader: "Bearer ${this._jwtToken}"};
  }

  @override
  bool loggedIn() {
    return true;
  }

  Future<List<String>> tables(http.Client client) async {
    final response = await client.get(this.dataUrl, headers: authHeaders());

    final Map<String, dynamic> tables = json.decode(response.body);
    final List<dynamic> tableNames = tables['tables'];

    return tableNames.map((table) => table['name']).toList().cast<String>();
  }

  @override
  String get name => _name;
}
