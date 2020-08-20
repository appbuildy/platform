import 'package:flutter_app/features/schemaInteractions/Screens.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_app/store/schema/ScreensStore.dart';
import 'package:flutter_app/store/userActions/CurrentScreen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('undo()', () {
    test('it places given widget to schemaStore', () {
      final SchemaStore schemaStore = new SchemaStore(components: []);
      final CurrentScreen screen = CurrentScreen(schemaStore);
      final button = new SchemaNodeButton();
      final userActions =
          new UserActions(screens: Screens(ScreensStore(), screen));

      userActions.placeWidget(button, Offset(1, 2));
      userActions.placeWidget(button, Offset(1, 5));

      expect(schemaStore.components.length, 2);
      expect(userActions.lastAction(), isNotNull);
      userActions.undo();
      userActions.undo();
      expect(schemaStore.components.length, 0);
    });
  });

  group('screens.createScreen()', () {
    test('it creates new screen()', () {});
  });
}
