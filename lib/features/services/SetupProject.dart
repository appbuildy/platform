import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/airtable/IRemoteTable.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/project_parameters_from_browser_query.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:http/http.dart' as http;

class SetupProject {
  CurrentUserStore userStore;
  ProjectParametersFromBrowserQuery settings;
  RemoteAttributes attributes;

  SetupProject(this.userStore, this.settings, this.attributes);

  Future<Project> setup(
      [AuthenticationService auth, http.Client client]) async {
    final httpClient = client ?? http.Client();
    await userStore.tryLogIn(auth ??
        AuthenticationService.defaultAuth(
            jwt: settings.jwt, url: settings.userUrl));

    final project = Project(settings.projectUrl, userStore.currentUser);
    await project.getData(httpClient);
    Client.credentials = project.airtableCredentials;
    await _fetchTables(project.airtableTables);
    return project;
  }

  Future<void> _fetchTables(List<IRemoteTable> tables) async {
    attributes.fetchTables(tables);
  }
}
