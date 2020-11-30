import 'dart:convert';

import 'package:flutter_app/features/airtable/airtable_table.dart';
import 'package:flutter_app/features/entities/User.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/features/services/project_parameters_from_browser_query.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:flutter_app/utils/SchemaConverter.dart';
import 'package:http/http.dart' as http;

class Project {
  User user;
  String url;
  String apiKey;
  String base;

  Project(this.url, [this.user]);

  static Future<Project> setup({
    AuthenticationService auth,
    http.Client client,
    CurrentUserStore userStore,
    ProjectParametersFromBrowserQuery settings,
    RemoteAttributes attributes
  }) async {
    return await SetupProject(userStore: userStore, attributes: attributes)
        .setup(auth, client);
  }

  void setAirtableCredentials({String apiKey, String base}) {
    print('setAirtableCredentials() called');
    this.apiKey = apiKey;
    this.base = base;
  }

  Map<String, dynamic> _fetchedData;
  Map<String, dynamic> get data => _fetchedData ?? {};
  Map<String, dynamic> get airtableCredentials =>
      _fetchedData['airtable_credentials'] ?? {};
  List<AirtableTable> get airtableTables => _fetchedData['tables']
      .map((r) => AirtableTable(r['name'].toString(), r['base']))
      .toList()
      .cast<AirtableTable>();
  String get slugUrl => _fetchedData['public_url'] ?? null;

  bool get _projectDataNotSet => (url.toString().contains('null'));

  Future<Map<String, dynamic>> getData(http.Client client) async {
    if (_projectDataNotSet) return {};

    try {
      final response = await client.get(this.url, headers: user?.authHeaders());
      final data = json.decode(response.body);
      _fetchedData = data;

      return data;
    } catch (e) {
      print("Failed to fetch project data from host $url");
      return {};
    }
  }

  Future<bool> save(SchemaConverter converter, {http.Client client}) async {
    if (_projectDataNotSet) return false;

    final serialiedProject = converter.toJson();
    if (this.apiKey != null && this.base != null) {
      serialiedProject['airtable_credentials'] = {
        'api_key': apiKey,
        'base': base
      };
    }

    final body = json.encode({'project': serialiedProject});

    final headers = user.authHeaders();
    headers['Content-type'] = 'application/json';

    await client.patch(url, headers: headers, body: body);

    return true;
  }
}
