import 'package:flutter/material.dart';
import 'package:flutter_app/features/layout/AppLayout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Query: ${Uri.base.queryParameters['jwt']}");
    return MaterialApp(
      title: 'bestNoCodeApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: AppLayout(),
      ),
    );
  }
}
