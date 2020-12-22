import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/loading/browser_preview.dart';
import 'package:flutter_app/ui/app_loader/app_loader.dart';

class ApplicationPreviewApp extends StatelessWidget {
  final BrowserPreview preview;
  const ApplicationPreviewApp({Key key, BrowserPreview preview})
      : this.preview = preview ?? const BrowserPreview(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: AppLoader(
        asyncBuilder: preview.load(),
      ),
    ));
  }
}
