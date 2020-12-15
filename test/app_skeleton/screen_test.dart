import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/shared_widgets.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var button = SharedWidget.button(text: 'test');
  final btn = WidgetDecorator(position: Offset(0, 0), child: button);
  final screen = Screen(id: RandomKey(), widgets: [btn]);
  final app = MaterialApp(
      title: 'Test',
      home: Scaffold(
          body: Center(
        child: screen,
      )));

  testWidgets('it renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    final textFinder = find.byType(SharedButton);
    expect(textFinder, findsOneWidget);
  });
}
