import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/SetupUserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNodeSpawner.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('toWidget() renders', (WidgetTester tester) async {
    SchemaNodeSpawner nodeSpawner = SchemaNodeSpawner(userActions: setupUserActions());

    final nodeButton = nodeSpawner.spawnSchemaNodeButton(position: Offset(1, 2));

    final testWidget = MaterialApp(
        title: 'Test',
        home: Scaffold(
            body: Center(
          child: nodeButton.toWidget(),
        )));

    await tester.pumpWidget(testWidget);
    expect(find.byType(Container), findsNWidgets(1));
  });
}
