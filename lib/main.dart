import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
import 'app_skeleton/application.dart';
import 'app_skeleton/loading/browser_preview.dart';
import 'features/layout/ProjectLoadingMiddleware.dart';
import 'features/services/project_parameters_from_browser_query.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BrowserPreview preview;
  Application application;
  bool isLoading;
  bool isPreviewMode;

  @override
  void initState() {
    super.initState();
    isPreviewMode = ProjectParametersFromBrowserQuery(window).isPreviewMode;
    isLoading = true;
    preview = BrowserPreview();

    initPreview();
  }

  Future<void> initPreview() async {
    if (isPreviewMode) {
      var applicationLoad = await preview.load();

      setState(() {
        application = applicationLoad;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isPreviewMode) {
      return application;
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
