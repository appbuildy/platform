import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/schemaInteractions/PlaceWidget.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('execute()', () {
    test('it places given widget to schemaStore', () {
      final schemaStore = new SchemaStore(components: []);
      final button = new SchemaNodeButton();
      final action = new PlaceWidget(widget: button, schemaStore: schemaStore);
      action.execute();
      expect(schemaStore.components.length, 1);
    });
  });
}
