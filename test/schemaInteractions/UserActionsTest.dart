import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/UserActions.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('redo()', () {
    test('it places given widget to schemaStore', () {
      final userActions = new UserActions();
      final SchemaStore schemaStore = new SchemaStore(components: []);
      final button = new SchemaNodeButton();

      userActions.placeWidget(button, schemaStore);
      expect(schemaStore.components.length, 1);
      userActions.undo();
      expect(schemaStore.components.length, 0);
    });
  });
}
