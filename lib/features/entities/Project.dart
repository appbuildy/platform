import 'dart:convert';

import 'package:flutter_app/features/entities/User.dart';
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
    print(data);
    _fetchedData = data;
    return data;
  }
}
