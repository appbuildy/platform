import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('undo()', () {
    test('it removes given widget from store', () {
      final schemaStore = new SchemaStore(components: []);
      final button = new SchemaNodeButton();
      final action = new PlaceWidget(node: button, schemaStore: schemaStore);
      action.execute();
      action.undo();
      expect(schemaStore.components.length, 0);
    });
  });

  group('execute()', () {
    test('it places given widget to schemaStore', () {
      final schemaStore = new SchemaStore(components: []);
      final button = new SchemaNodeButton();
      final action = new PlaceWidget(node: button, schemaStore: schemaStore);
      action.execute();
      expect(schemaStore.components.length, 1);
    });
  });
}
