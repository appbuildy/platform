import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:http/http.dart';

class AirtableClient implements IRemoteTable {
  String apiKey;
  String base;
  String table;
  String apiUrl;
  Client httpClient;
  static Map<String, dynamic> credentials = {};

  factory AirtableClient.defaultClient({
    String table = 'Table 1',
    String apiKey,
    String base,
  }) {
    apiKey = apiKey ?? credentials['api_key'];
    base = base ?? credentials['base'];

    return AirtableClient(
      table: table,
      apiKey: apiKey,
      base: base,
      httpClient: Client(),
    );
  }

  AirtableClient({
    this.apiUrl = 'https://api.airtable.com/v0/',
    this.table,
    this.apiKey,
    this.base,
    this.httpClient,
  });

  String get requestUrl => '${this.apiUrl}${this.base}/${this.table}';

  @override
  Future<Map<String, dynamic>> records() async {
    final response = await this.httpClient.get(
      requestUrl,
      headers: {HttpHeaders.authorizationHeader: "Bearer ${this.apiKey}"},
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> record(String id) async {
    final response = await this
        .httpClient
        .get('${this.apiUrl}${this.base}/${this.table}/$id');
    return json.decode(response.body);
  }
}
