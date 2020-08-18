import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('toWidget() renders', (WidgetTester tester) async {
    final nodeButton = SchemaNodeButton(position: null);

    final testWidget = MaterialApp(
        title: 'Test',
        home: Scaffold(
            body: Center(
          child: nodeButton.toWidget(),
        )));

    await tester.pumpWidget(testWidget);
    expect(find.text('Button'), findsNWidgets(1));
  });
}
