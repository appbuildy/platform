import 'package:flutter/material.dart';
import 'package:flutter_app/ui/app_builder/app_builder.dart';
import 'package:universal_html/html.dart';

import 'ui/app_preview/application_preview_app.dart';
import 'features/services/browser_query_data.dart';

void main() {
  runApp(
    /// wrap into Mock Browser Query Data in tests instead
    BrowserQueryData(
      window: window,
      child: SharedApp(),
    ),
  );
}

class SharedApp extends StatelessWidget {
  const SharedApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BrowserQueryData.of(context).isPreview
      ? const ApplicationPreviewApp()
      : const ApplicationBuilderApp();
}
