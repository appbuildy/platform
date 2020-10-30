import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final app = MaterialApp(
      title: 'Test',
      home: Scaffold(
          body: Center(
        child: Application(),
      )));
  testWidgets('it renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);
  });
}
