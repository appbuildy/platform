import 'package:flutter_app/features/entities/Project.dart';

import '../project_parameters_from_browser_query.dart';
import 'package:http/http.dart' as http;

class SetupPreview {
  ProjectParametersFromBrowserQuery settings;
  http.Client client;

  SetupPreview({settings, client}) {
    this.settings = settings;
    this.client = client ?? http.Client();
  }

  Future<Project> setup() async {
    final project = Project(settings.projectUrl);
    await project.getData(client);
    return project;
  }
}
