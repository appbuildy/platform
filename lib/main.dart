import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'app_skeleton/application_widget.dart';
import 'features/layout/ProjectLoadingMiddleware.dart';
import 'features/services/project_parameters_from_browser_query.dart';

void main() {
  runApp(
    ProjectParametersFromBrowserQuery(window).isPreviewMode
        ? PreviewApp()
        : BuilderApp(),
  );
}

class PreviewApp extends StatelessWidget {
  const PreviewApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ApplicationWidget(),
      ),
    );
  }
}

class BuilderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
