import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/ui/AllActions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAction extends Mock implements SchemaAction {
  String value;
  bool isCalled = false;
  MockAction(this.value);

  @override
  Function toFunction(UserActions userActions) {
    return () => {isCalled = true};
  }
}

void main() {
  testWidgets('Widget() renders', (WidgetTester tester) async {
    final schemaStore = SchemaStore(components: []);
    final anotherScreen = SchemaStore(components: []);
    final ScreensStore screens =
        ScreensStore(screens: [schemaStore, anotherScreen]);
    final action = MockAction('val1');
    final allActions = AllActions(screens: screens.screens);

    final SchemaNodeButton btn = SchemaNodeButton(
        actions: {'Tap': action},
        position: Offset(2222, 2),
        size: Offset(22, 33));
    schemaStore.add(btn);

    final testWidget = MaterialApp(
        title: 'Test',
        home: Scaffold(
            body: Center(
          child: allActions,
        )));

    await tester.pumpWidget(testWidget);
    expect(find.byType(Column), findsNWidgets(1));
  });
}
