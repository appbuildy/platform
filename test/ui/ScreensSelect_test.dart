import 'package:flutter/material.dart';
import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/schemaAction.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_app/ui/ScreensSelect.dart';
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
    //TODO: Move setup to helper
    final schemaStore = SchemaStore(name: 'nam1', components: []);
    final anotherScreen = SchemaStore(name: 'name2', components: []);
    final ScreensStore screens =
        ScreensStore(screens: [schemaStore, anotherScreen]);
    final action = GoToScreenAction('val');
    final userActions =
        UserActions(screens: Screens(screens, CurrentScreen(schemaStore)));
    final allActions = ScreensSelect(
        userActions: userActions, action: action, screens: screens.screens);

    final testWidget = MaterialApp(
        title: 'Test',
        home: Scaffold(
            body: Center(
          child: allActions,
        )));

    await tester.pumpWidget(testWidget);
    await tester.tap(find.text(schemaStore.name));
    await tester.pump();

    expect(action.value, equals(schemaStore.name));
    expect(find.text(schemaStore.name), findsNWidgets(1));
  });
}
