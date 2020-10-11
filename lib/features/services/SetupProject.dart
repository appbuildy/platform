import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/SettingsParser.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:http/http.dart' as http;

class SetupProject {
  CurrentUserStore userStore;
  SettingsParser settings;

  SetupProject(this.userStore, this.settings);

  Future<Project> setup(
      [AuthenticationService auth, http.Client client]) async {
    await userStore.tryLogIn(auth ??
        AuthenticationService.defaultAuth(
            jwt: settings.jwt, url: settings.userUrl));

    final project = Project(settings.projectUrl, userStore.currentUser);
    await project.getData(client ?? http.Client());
    return project;
  }
}
