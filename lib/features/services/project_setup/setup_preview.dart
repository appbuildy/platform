import 'package:flutter_app/features/entities/Project.dart';
import 'package:universal_html/html.dart';

import 'package:flutter_app/features/airtable/airtable_client.dart';
import 'package:flutter_app/features/services/browser_query_data.dart';
import 'package:http/http.dart' as http;

class SetupPreview {
  // BrowserQueryData settings;
  http.Client client;

  SetupPreview({settings, client}) {
    // this.settings = settings ?? BrowserQueryData(window);
    this.client = client ?? http.Client();
  }

  Future<Project> setup() async {
    print('setup preview start');
    final project = Project(browserData.projectUrl);
    print('getting project data');
    await project.getData(client);
    print('populating airtable creds');
    AirtableClient?.credentials = project?.airtableCredentials;
    print('setup preview end');
    return project;
  }
}
