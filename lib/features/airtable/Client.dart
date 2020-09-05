import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

class Client {
  String apiKey;
  String base;
  String table;
  String apiUrl;
  http.Client httpClient;
  Client(
      {this.apiUrl = 'https://api.airtable.com/v0/',
      this.table,
      this.apiKey,
      this.base,
      this.httpClient});

  Future<Map<String, dynamic>> records() async {
    final response =
        await this.httpClient.get('${this.apiUrl}${this.base}/${this.table}');
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> record(String id) async {
    final response = await this
        .httpClient
        .get('${this.apiUrl}${this.base}/${this.table}/$id');

    return json.decode(response.body);
  }
}
