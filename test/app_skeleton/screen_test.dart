import 'package:flutter/material.dart';
import 'package:flutter_app/app_skeleton/screen.dart';
import 'package:flutter_app/app_skeleton/store/screen_store.dart';
import 'package:flutter_app/shared_widgets/shared_widget.dart';
import 'package:flutter_app/shared_widgets/widget_decorator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  final btn = WidgetDecorator(
      position: Offset(55, 55), widget: SharedWidget.button(text: 'test'));
  final screen = Screen(widgets: [btn]);
  final app = MultiProvider(
      providers: [Provider<ScreenStore>(create: (_) => ScreenStore(screen))],
      child: MaterialApp(
          title: 'Test',
          home: Scaffold(
              body: Center(
            child: screen,
          ))));

  testWidgets('it renders', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    final textFinder = find.text('test');
    expect(textFinder, findsOneWidget);
  });
}
