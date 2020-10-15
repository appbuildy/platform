import 'package:flutter_app/features/schemaNodes/properties/SchemaBoolPropery.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toJson() maps to JSON', () {
    SchemaBoolProperty booleanProp = SchemaBoolProperty('Boolean', true);
    final jsonBooleanProp = booleanProp.toJson();
    expect(jsonBooleanProp['name'], equals(booleanProp.name));
    expect(jsonBooleanProp['value'], equals(true));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> targetJson = {
      'name': 'THis IS BooLean',
      'value': false,
      'propertyClass': 'SchemaBoolProperty',
    };

    final boolProp = SchemaBoolProperty.fromJson(targetJson);

    expect(boolProp.value, equals(false));
  });
}
