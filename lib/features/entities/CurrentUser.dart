import 'dart:convert';

import 'User.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class CurrentUser extends User {
  String _name;
  String _JwtToken;
  String dataUrl;
  CurrentUser(this._name, this._JwtToken, this.dataUrl);

  @override
  bool loggedIn() {
    return true;
  }

  Future<List<String>> tables(http.Client client) async {
    final response = await client.get(this.dataUrl,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${this._JwtToken}"});
    print(response);

    final Map<String, dynamic> tables = json.decode(response.body);
    final List<dynamic> tableNames = tables['tables'];

    return tableNames.map((table) => table['name']).toList().cast<String>();
  }

  @override
  String get name => _name;
}
