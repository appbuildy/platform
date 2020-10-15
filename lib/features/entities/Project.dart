import 'dart:convert';

import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:http/http.dart';

class Project {
  User user;

  String url;
  Map<String, dynamic> _fetchedData;
  Project(this.url, this.user);
  Map<String, dynamic> get data => _fetchedData ?? {};

  bool get _projectDataNotSet => (url.toString().contains('null'));

  Future<Map<String, dynamic>> getData(Client client) async {
    if (_projectDataNotSet) return {};

    try {
      final response = await client.get(this.url, headers: user.authHeaders());
      final data = json.decode(response.body);
      _fetchedData = data;
      return data;
    } catch (e) {
      print("Failed to fetch project data from host $url");
      return {};
    }
  }

  Future<bool> save(SchemaConverter converter, {Client client}) async {
    if (_projectDataNotSet) return false;

    final body = json.encode({'project': converter.toJson()});
    final headers = user.authHeaders();
    headers['Content-type'] = 'application/json';

    await client.patch(url, headers: headers, body: body);

    return true;
  }
}
