import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/features/schemaNodes/properties/SchemaColorProperty.dart';
import 'package:flutter/material.dart';

void main() {
  test('toJson() maps to JSON', () {
    final SchemaColorProperty colorProp = SchemaColorProperty('color', Color(0xFF000000));
    final jsonColorProp = colorProp.toJson();
    expect(jsonColorProp['name'], equals(colorProp.name));
    expect(jsonColorProp['value'], equals(colorProp.value.value));
  });

  test('fromJson() deserialization', () {
    final Map<String, dynamic> jsonTarget = {
      'propertyClass': 'SchemaColorProperty',
      'name': 'color',
      'value': Color(0xFF000000).value.toString(),
    };

    final SchemaColorProperty colorProp = SchemaColorProperty.fromJson(jsonTarget);
    expect(colorProp.value, equals(Color(0xFF000000)));
  });
}
