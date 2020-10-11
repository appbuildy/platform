import 'dart:convert';

import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:http/http.dart';

class Project {
  User user;

  String url;
  Map<String, dynamic> _fetchedData;
  Project(this.url, this.user);
  Map<String, dynamic> get data => _fetchedData ?? {};

  Future<Map<String, dynamic>> getData(Client client) async {
    final response = await client.get(this.url, headers: user.authHeaders());
    final data = json.decode(response.body);
    _fetchedData = data;
    return data;
  }

  Future<bool> save(SchemaConverter converter, {Client client}) async {
    await client.patch(url, body: converter.toJson().toString());

    return true;
  }
}
