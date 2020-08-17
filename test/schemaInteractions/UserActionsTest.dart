import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('undo()', () {
    test('it places given widget to schemaStore', () {
      final userActions = new UserActions();
      final SchemaStore schemaStore = new SchemaStore(components: []);
      final button = new SchemaNodeButton();

      userActions.placeWidget(button, schemaStore, Offset(1, 2));
      userActions.placeWidget(button, schemaStore, Offset(1, 5));

      expect(schemaStore.components.length, 2);
      expect(userActions.lastAction(), isNotNull);
      userActions.undo();
      userActions.undo();
      expect(schemaStore.components.length, 0);
    });
  });
}
