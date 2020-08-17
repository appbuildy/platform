import 'package:flutter_app/features/canvas/SchemaNode.dart';
import 'package:flutter_app/features/canvas/SchemaNodeProperty.dart';
import 'package:flutter_app/features/schemaInteractions/ChangeNodeProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('execute()', () {
    test('it changes node property to given', () {
      final text = SchemaNodeText();
      final newProp = SchemaStringProperty('Text', '33');
      final changeProp = ChangeNodeProperty(node: text, setProperty: newProp);
      changeProp.execute();
      final textPropValue = text.properties['Text'].value;

      expect(textPropValue, equals(newProp.value));
    });
  });
}
