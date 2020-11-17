import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/application.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/shared_widgets/shared_widget.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_app/utils/RandomKey.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final btn = WidgetDecorator(
      position: Offset(55, 55), widget: SharedWidget.button(text: 'test'));
  final screen = Screen(widgets: [btn]);

  final app = Application(screens: {RandomKey(): screen});

  testWidgets('it renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final textFinder = find.text('test');
    expect(textFinder, findsOneWidget);
  });
}
