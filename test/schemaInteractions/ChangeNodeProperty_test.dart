import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_app/features/schemaNodes/SchemaNode.dart';
import 'package:flutter_app/store/schema/SchemaStore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SchemaNode text;
  SchemaNodeProperty newProp;
  ChangeNodeProperty changeProp;
  SchemaStore schemaStore;
  Function selectNodeForEdit;

  setUp(() {
    schemaStore = SchemaStore(components: []);
    text = SchemaNodeText();
    schemaStore.add(text);
    selectNodeForEdit = (SchemaNode node) {};

    newProp = SchemaStringProperty('Text', '33');
    changeProp = ChangeNodeProperty(
        selectNodeForEdit: selectNodeForEdit,
        schemaStore: schemaStore,
        node: text,
        newProp: newProp);
  });

  group('undo()', () {
    test('it changes node to previous value', () {
      final oldValue = text.properties['Text'].value;
      changeProp.execute();
      changeProp.undo();

      expect(text.properties['Text'].value, equals(oldValue));
    });
  });

  group('execute()', () {
    test('it changes node property to given', () {
      changeProp.execute();
      final textPropValue = text.properties['Text'].value;

      expect(textPropValue, equals(newProp.value));
    });
  });
}
