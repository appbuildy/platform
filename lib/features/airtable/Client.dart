import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:http/http.dart' as http;

class Client implements IRemoteTable {
  String apiKey;
  String base;
  String table;
  String apiUrl;
  http.Client httpClient;

  factory Client.defaultClient(
      {String table = 'Table 1',
      String apiKey = 'keyzl1cUgqEpq4zBB',
      String base = 'apphUx0izMa4P5pzQ'}) {
    return Client(
        table: table, apiKey: apiKey, base: base, httpClient: http.Client());
  }

  Client(
      {this.apiUrl = 'https://api.airtable.com/v0/',
      this.table,
      this.apiKey,
      this.base,
      this.httpClient});

  @override
  Future<Map<String, dynamic>> records() async {
    final response = await this.httpClient.get(
        '${this.apiUrl}${this.base}/${this.table}',
        headers: {HttpHeaders.authorizationHeader: "Bearer ${this.apiKey}"});
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> record(String id) async {
    final response = await this
        .httpClient
        .get('${this.apiUrl}${this.base}/${this.table}/$id');

    return json.decode(response.body);
  }
}
