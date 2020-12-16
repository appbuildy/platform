import 'package:flutter/cupertino.dart';
import 'package:flutter_app/features/services/SetupProject.dart';

import 'application_loaded_from_json.dart';

class BrowserPreview {
  SetupProject setupProject;
  BrowserPreview([setupProject]) {
    this.setupProject = setupProject ?? SetupProject();
  }

  Future<Widget> load() async {
    var project = await setupProject.setupPreview();

    return ApplicationLoadedFromJson(project.data).load();
  }
}
