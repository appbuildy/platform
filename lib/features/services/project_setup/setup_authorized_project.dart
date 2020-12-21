import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:universal_html/html.dart';

import 'package:flutter_app/features/services/project_parameters_from_browser_query.dart';
import 'package:http/http.dart' as http;

class SetupAuthorizedProject {
  ProjectParametersFromBrowserQuery settings;
  http.Client client;
  RemoteAttributes attributes;
  AuthenticationService auth;
  CurrentUserStore userStore;

  SetupAuthorizedProject({auth, attributes, userStore, settings, client}) {
    this.settings = settings ?? ProjectParametersFromBrowserQuery(window);
    this.client = client ?? http.Client();
    this.auth = auth;
    this.attributes = attributes;
    this.userStore = userStore;
  }

  Future<Project> setup() async {
    settings ??= ProjectParametersFromBrowserQuery(window);
    final httpClient = client ?? http.Client();
    await userStore.tryLogIn(auth ??
        AuthenticationService.defaultAuth(
            jwt: settings.jwt, url: settings.userUrl));

    final project = Project(settings.projectUrl, userStore.currentUser);
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
