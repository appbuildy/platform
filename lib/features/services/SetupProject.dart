import 'package:flutter_app/features/airtable/Client.dart';
import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SettingsParser.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:http/http.dart' as http;

class SetupProject {
  CurrentUserStore userStore;
  SettingsParser settings;
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
    //await _fetchTables(project.airtableTables);
    Client.credentials = project.airtableCredentials;
    return project;
  }

  Future<void> _fetchTables(List<String> tables) async {
    attributes.fetchTables(tables);
  }
}
