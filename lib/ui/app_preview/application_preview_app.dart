import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/entities/skeleton_entities.dart';
import 'package:flutter_app/app_skeleton/preview_ui/view.dart';
import 'package:flutter_app/features/services/SetupProject.dart';
import 'package:flutter_app/ui/app_loader/app_loader.dart';

class ApplicationPreviewApp extends StatelessWidget {
  const ApplicationPreviewApp({Key key}) : super(key: key);

  Future<Widget> loadPreview() async {
    SkeletonProject  project = await const SetupProject().setupPreview();
    
    return SkeletonPreview(project: project);
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
