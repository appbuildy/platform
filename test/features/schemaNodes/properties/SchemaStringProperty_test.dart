import 'package:flutter_app/features/schemaNodes/properties/SchemaStringProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromJson loads from dynamic map', () async {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaStringProperty',
      'name': 'Text',
      'value': 'Random'
    };

    final SchemaStringProperty prop = SchemaStringProperty.fromJson(targetJson);
    expect(prop.name, equals('Text'));
    expect(prop.value, equals('Random'));
  });
}
