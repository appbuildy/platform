import 'package:flutter_app/features/entities/Project.dart';
import 'package:flutter_app/features/services/AuthenticationService.dart';
import 'package:flutter_app/features/services/browser_query_data.dart';
import 'package:flutter_app/features/services/project_setup/setup_authorized_project.dart';
import 'package:flutter_app/features/services/project_setup/setup_preview.dart';
import 'package:flutter_app/store/schema/CurrentUserStore.dart';
import 'package:flutter_app/store/userActions/RemoteAttributes.dart';
import 'package:http/http.dart' as http;

class SetupProject {
  final CurrentUserStore userStore;
  // final BrowserQueryData settings;
  final RemoteAttributes attributes;

  const SetupProject({
    this.userStore,
    // this.settings,
    this.attributes,
  });

  Future<Project> setup([auth, client]) async {
    return await setupAuthorized(auth, client);
  }

  Future<Project> setupAuthorized(
      [AuthenticationService auth, http.Client client]) async {
    return await SetupAuthorizedProject(
      auth: auth,
      userStore: userStore,
      attributes: attributes,
      client: client,
      // settings: settings,
    ).setup();
  }

  Future<Project> setupPreview() async {
    return await SetupPreview().setup();
  }
}
