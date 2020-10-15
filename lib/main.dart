import 'package:flutter/material.dart';

import 'features/layout/ProjectLoadingMiddleware.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
