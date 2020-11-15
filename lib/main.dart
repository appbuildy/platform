import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'app_skeleton/application_widget.dart';
import 'features/layout/ProjectLoadingMiddleware.dart';
import 'features/services/project_parameters_from_browser_query.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ProjectParametersFromBrowserQuery(window).isPreviewMode) {
      return ApplicationWidget();
    } else {
      return MaterialApp(
        title: 'AppBuildy — create your apps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: ProjectSetupMiddleware(),
        ),
      );
    }
  }
}
