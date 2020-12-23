import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/application_loaded_from_json.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/ui/app_loader/app_loader.dart';

class ApplicationPreviewApp extends StatelessWidget {
  const ApplicationPreviewApp({Key key}) : super(key: key);

  Future<Widget> loadPreview() async {
    var project = await const SetupProject().setupPreview();
    return ApplicationLoadedFromJson(project).load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: AppLoader(
        asyncBuilder: loadPreview(),
      ),
    ));
  }
}
