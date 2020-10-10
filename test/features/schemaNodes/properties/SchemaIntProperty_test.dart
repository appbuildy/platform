import 'package:flutter_app/features/schemaNodes/properties/SchemaIntProperty.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps JSON', () {
    final SchemaIntProperty intProp = SchemaIntProperty('Integer', 322);
    final jsonIntProperty = intProp.toJson();
    expect(jsonIntProperty['value'], equals(322));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'propertyClass': 'SchemaIntProperty',
      'name': 'Int',
      'value': '1337',
    };

    final intProp = SchemaIntProperty.fromJson(targetJson);
    expect(intProp.name, equals('Int'));
    expect(intProp.value, equals(1337));
  });
}
