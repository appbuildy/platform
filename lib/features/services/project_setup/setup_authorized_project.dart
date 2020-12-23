import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:universal_html/html.dart';

import 'package:flutter_app/features/services/browser_query_data.dart';
import 'package:http/http.dart' as http;

class SetupAuthorizedProject {
  // BrowserQueryData settings;
  http.Client client;
  RemoteAttributes attributes;
  AuthenticationService auth;
  CurrentUserStore userStore;

  SetupAuthorizedProject({auth, attributes, userStore, settings, client}) {
    // this.settings = settings ?? BrowserQueryData(window);
    this.client = client ?? http.Client();
    this.auth = auth;
    this.attributes = attributes;
    this.userStore = userStore;
  }

  Future<Project> setup() async {
    // settings ??= BrowserQueryData(window);
    final httpClient = client ?? http.Client();
    await userStore.tryLogIn(
      auth ??
          AuthenticationService.defaultAuth(
            jwt: browserData.jwt,
            url: browserData.userUrl,
          ),
    );

    final project = Project(browserData.projectUrl, userStore.currentUser);
    await project.getData(httpClient);
    _setProjectCredentials(project);
    await _fetchTables(project.airtableTables);
    return project;
  }

  void _setProjectCredentials(project) {
    AirtableClient.credentials = project.airtableCredentials;
  }

  Future<void> _fetchTables(List<IRemoteTable> tables) async {
    attributes.fetchTables(tables);
  }
}
